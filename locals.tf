locals {
    ## Generic routes to Peer, to be set in Owner VPC's route tables
    generic_routes_to_peer = (var.generalize_routes_to_peer 
                                && length(var.peer_cidrs) > 0) ? (
                                    setproduct(data.aws_route_tables.owner[0].ids, var.peer_cidrs)) : []

    ## Specific routes to Peer, to be set in Owner VPC's route tables
    specific_routes_to_peer = [for route in var.specific_routes_to_peer: 
                    setproduct([route.route_table_id], split(",", route.cidrs))]

    routes_to_peer = concat(local.generic_routes_to_peer, 
                                            try(local.specific_routes_to_peer[0], []))

    ## Generic routes to Owner VPC, to be set in Peer VPC's route tables
    generic_routes_to_owner = (var.generalize_routes_to_owner 
                                && length(var.owner_cidrs) > 0) ? (
                                    setproduct(data.aws_route_tables.peer[0].ids, var.owner_cidrs)) : []

    ## Specific routes to Owner VPC, to be set in Peer VPC's route tables
    specific_routes_to_owner = [for route in var.specific_routes_to_owner: 
                    setproduct([route.route_table_id], split(",", route.cidrs))]

    routes_to_owner = concat(local.generic_routes_to_owner, 
                                            try(local.specific_routes_to_owner[0], []))
}