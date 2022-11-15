output "id" {
    description = "The ID of the VPC Peering Connection."
    value       = try(aws_vpc_peering_connection.this[0].id, "")
}

output "status" {
    description = "The status of the VPC Peering Connection request."
    value       = try(aws_vpc_peering_connection.this[0].accept_status, "")
}

output "owner_connection_option" {
    description = "The ID of the VPC Peering Connection Owner Option."
    value       = try(aws_vpc_peering_connection_options.owner[0].id, "")
}

output "peer_connection_option" {
    description = "The ID of the VPC Peering Connection Peer Option."
    value       = try(aws_vpc_peering_connection_options.peer[0].id, "")
}