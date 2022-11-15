output "id" {
    description = "The ID of the VPC Peering Connection."
    value       = try(aws_vpc_peering_connection.this[0].id, "")
}

output "status" {
    description = "The status of the VPC Peering Connection request."
    value       = try(aws_vpc_peering_connection.this[0].accept_status, "")
}

output "requester_option" {
    description = "The ID of the VPC Peering Connection Requester Option."
    value       = try(aws_vpc_peering_connection_options.requester[0].id, "")
}

output "accepter_option" {
    description = "The ID of the VPC Peering Connection Accepter Option."
    value       = try(aws_vpc_peering_connection_options.accepter[0].id, "")
}