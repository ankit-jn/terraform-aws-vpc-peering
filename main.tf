resource "aws_vpc_peering_connection" "this" {

    count = contains(["owner", "both"], var.vpc_peering_connection_handler) ? 1 : 0

    provider = aws.owner

    peer_owner_id = coalesce(var.owner_account_id, data.aws_caller_identity.owner[0].account_id)

    vpc_id      = var.owner_vpc_id
    peer_vpc_id = var.peer_vpc_id

    peer_region = coalesce(var.peer_vpc_region, (var.vpc_peering_connection_handler == "owner") ? data.aws_region.owner[0].name : data.aws_region.peer[0].name)
    auto_accept = false
    
    tags = merge({"Owner" = var.owner_vpc_id}, 
                    {"Peer" = var.peer_vpc_id}, 
                    var.tags)
}

resource aws_vpc_peering_connection_accepter "this" {
    
    count = contains(["peer", "both"], var.vpc_peering_connection_handler) ? 1 : 0

    provider = aws.peer

    vpc_peering_connection_id = (var.vpc_peering_connection_handler == "peer") ? var.peering_connection_id : aws_vpc_peering_connection.this[0].id
    auto_accept = var.auto_accept_peering

    tags = merge({"Owner" = var.owner_vpc_id}, 
                    {"Peer" = var.peer_vpc_id}, 
                    var.tags)
}

resource aws_vpc_peering_connection_options "owner" {

    count = var.allow_owner_vpc_dns_resolution ? 1 : 0

    provider = aws.owner

    vpc_peering_connection_id = aws_vpc_peering_connection.this[0].id

    requester {
        allow_remote_vpc_dns_resolution = true
    }

    depends_on = [
        aws_vpc_peering_connection.this,
        aws_vpc_peering_connection_accepter.this
    ]

}

resource aws_vpc_peering_connection_options "peer" {
  
    count = var.allow_owner_vpc_dns_resolution ? 1 : 0
  
    provider = aws.peer
    
    vpc_peering_connection_id = aws_vpc_peering_connection_accepter.this[0].id

    accepter {
        allow_remote_vpc_dns_resolution = true
    }

    depends_on = [
        aws_vpc_peering_connection_accepter.this
    ]
}

## Route Updates in Route Tables on Owner Side VPC
resource aws_route "owner_to_peer" {

    for_each = { for route_pair in local.routes_to_peer: 
                                    format("%s.%s", route_pair[0], trimspace(route_pair[1])) => route_pair}

    provider = aws.owner

    route_table_id         = each.value[0]
    destination_cidr_block = trimspace(each.value[1])
    
    vpc_peering_connection_id = aws_vpc_peering_connection.this[0].id

    timeouts {
        create = "5m"
    }
}

## Route Updates in Route Tables on Peer Side VPC
resource aws_route "peer_to_owner" {

    for_each = { for route_pair in local.routes_to_owner: 
                                                    format("%s.%s", route_pair[0], trimspace(route_pair[1])) => route_pair}

    provider = aws.peer

    route_table_id         = each.value[0]
    destination_cidr_block = trimspace(each.value[1])
    
    vpc_peering_connection_id = aws_vpc_peering_connection_accepter.this[0].id

    timeouts {
        create = "5m"
    }
}