variable "vpc_peering_connection_side" {
    description = "Side of the VPC Peering Connection."
    type        = string
    default     = "BOTH"

    validation {
        condition = contains(["REQUESTER", "ACCEPTER", "BOTH"], var.vpc_peering_connection_side)
        error_message = "Allowed Values are `REQUESTER`, `ACCEPTER`, `BOTH`."
    }
}

variable "owner_account_id" {
    description = "(Optional) The AWS account ID of the owner of the peer VPC."
    type        = string
    default     = null
}

variable "owner_vpc_id" {
    description = "(Required) The ID of the requester VPC."
    type        = string
}

variable "accepter_vpc_id" {
    description = "(Required) The ID of the VPC with which you are creating the VPC Peering Connection."
    type        = string
}

variable "accepter_vpc_region" {
    description = "(Optional) The region of the accepter VPC of the VPC Peering Connection."
    type        = string
    default     = null
}

variable "peering_connection_id" {
    description = "(Optional) VPC Peering Connection ID. Required if `vpc_connection_side` is set as `ACCEPTER`" 
    type        = string
    default     = null   
}

variable "auto_accept_peering" {
    description = "Flag to decide if peering request should be accepted."
    type        = bool
    default     = false
}

variable "allow_owner_vpc_dns_resolution" {
    description = <<EOF
Flag to decide if allow a local VPC to resolve public DNS hostnames to  
private IP addresses when queried from instances in the peer VPC.
EOF
    type        = bool
    default     = false
}

variable "allow_accepter_vpc_dns_resolution" {
    description = <<EOF
Flag to decide if allow a local VPC to resolve public DNS hostnames to  
private IP addresses when queried from instances in the peer VPC.
EOF
    type        = bool
    default     = false
}



variable "tags" {
    description = "Map of tags to be assigned to Peering connection"
    type        = map(string)
    default     = {}
}