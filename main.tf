resource "aws_vpc_peering_connection" "this" {

    count = contains(["REQUESTER", "BOTH"], var.vpc_peering_connection_side) ? 1 : 0

    provider = aws.requester

    peer_owner_id = coalesce(var.owner_account_id, data.aws_caller_identity.requester[0].account_id)

    vpc_id      = var.owner_vpc_id
    peer_vpc_id = var.accepter_vpc_id

    peer_region = coalesce(var.accepter_vpc_region, (var.vpc_peering_connection_side == "REQUESTER") ? data.aws_region.requester[0].name : data.aws_region.accepter[0].name)
    auto_accept = false
    
    tags = merge({"Side" = "Requester"},
                    {"Owner" = var.owner_vpc_id}, 
                    {"Peer" = var.accepter_vpc_id}, 
                    var.tags)
}

resource aws_vpc_peering_connection_accepter "this" {
    
    count = contains(["ACCEPTER", "BOTH"], var.vpc_peering_connection_side) ? 1 : 0

    provider = aws.accepter

    vpc_peering_connection_id = (var.vpc_peering_connection_side == "ACCEPTER") ? var.peering_connection_id : aws_vpc_peering_connection.this[0].id
    auto_accept = var.auto_accept_peering

    tags = merge({"Side" = "Accepter"},
                    {"Owner" = var.owner_vpc_id}, 
                    {"Peer" = var.accepter_vpc_id}, 
                    var.tags)
}

resource aws_vpc_peering_connection_options "requester" {

    count = var.allow_owner_vpc_dns_resolution ? 1 : 0

    provider = aws.requester

    vpc_peering_connection_id = aws_vpc_peering_connection.this[0].id

    requester {
        allow_remote_vpc_dns_resolution = true
    }

    depends_on = [
        aws_vpc_peering_connection.this,
        aws_vpc_peering_connection_accepter.this
    ]

}

resource aws_vpc_peering_connection_options "accepter" {
  
    count = var.allow_owner_vpc_dns_resolution ? 1 : 0
  
    provider = aws.accepter
    
    vpc_peering_connection_id = aws_vpc_peering_connection_accepter.this[0].id

    accepter {
        allow_remote_vpc_dns_resolution = true
    }

    depends_on = [
        aws_vpc_peering_connection_accepter.this
    ]
}