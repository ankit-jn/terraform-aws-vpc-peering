data aws_caller_identity "requester" {
    count = contains(["REQUESTER", "BOTH"], var.vpc_peering_connection_side) ? 1 : 0

    provider = aws.requester
}

data aws_caller_identity "accepter" {
    count = contains(["ACCEPTER", "BOTH"], var.vpc_peering_connection_side) ? 1 : 0

    provider = aws.requester
}

data aws_region "requester" {
    count = contains(["REQUESTER", "BOTH"], var.vpc_peering_connection_side) ? 1 : 0

    provider = aws.accepter
}

data aws_region "accepter" {
    count = contains(["ACCEPTER", "BOTH"], var.vpc_peering_connection_side) ? 1 : 0
    
    provider = aws.accepter
}