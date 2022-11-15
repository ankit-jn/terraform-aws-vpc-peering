data aws_caller_identity "owner" {
    count = contains(["owner", "both"], var.vpc_peering_connection_handler) ? 1 : 0

    provider = aws.owner
}

data aws_caller_identity "peer" {
    count = contains(["peer", "both"], var.vpc_peering_connection_handler) ? 1 : 0

    provider = aws.owner
}

data aws_region "owner" {
    count = contains(["owner", "both"], var.vpc_peering_connection_handler) ? 1 : 0

    provider = aws.peer
}

data aws_region "peer" {
    count = contains(["peer", "both"], var.vpc_peering_connection_handler) ? 1 : 0
    
    provider = aws.peer
}

data aws_route_tables "owner" {
    count = var.generalize_routes_to_peer ? 1 : 0

    provider = aws.owner
    vpc_id = var.owner_vpc_id
}

data "aws_route_tables" "peer" {
    count = var.generalize_routes_to_owner ? 1 : 0

    provider = aws.peer
    vpc_id = var.peer_vpc_id
}