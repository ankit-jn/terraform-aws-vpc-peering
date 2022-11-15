variable "vpc_peering_connection_handler" {
    description = "Peering Connection Handler."
    type        = string
    default     = "both"

    validation {
        condition = contains(["owner", "peer", "both"], var.vpc_peering_connection_handler)
        error_message = "Allowed Values are `owner`, `peer`, `both`."
    }
}

variable "owner_account_id" {
    description = "(Optional) The AWS account ID of the owner of the peer VPC."
    type        = string
    default     = null
}

variable "owner_vpc_id" {
    description = "(Required) The ID of the owner VPC."
    type        = string
}

variable "peer_vpc_id" {
    description = "(Required) The ID of the VPC with which you are creating the VPC Peering Connection."
    type        = string
}

variable "peer_vpc_region" {
    description = "(Optional) The region of the Peer VPC of the VPC Peering Connection."
    type        = string
    default     = null
}

variable "peering_connection_id" {
    description = "(Optional) VPC Peering Connection ID. Required if `vpc_connection_side` is set as `peer`" 
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

variable "allow_peer_vpc_dns_resolution" {
    description = <<EOF
Flag to decide if allow a local VPC to resolve public DNS hostnames to  
private IP addresses when queried from instances in the peer VPC.
EOF
    type        = bool
    default     = false
}

variable "generalize_routes_to_peer" {
    description = "Flag to decide if Routes to `peer_cidrs` should be set in all Owner VPC's route tables"
    type        = bool
    default     = false
}

variable "peer_cidrs" { 
    description = "The list of CIDRs for which routes should be created in all Owner VPC's route tables"
    type        = list(string)
    default     = []
}

variable "specific_routes_to_peer" {
    description = "The specific routes to Peer VPC through VPC peering connection"
    type = list(map(string))
    default = []
}

variable "generalize_routes_to_owner" {
    description = "Flag to decide if Routes to `owner_cidrs` should be set in all Peer VPC's route tables."
    type        = bool
    default     = false
}

variable "owner_cidrs" { 
    description = "The list of CIDRs for which routes should be created in all Peer VPC's route tables."
    type        = list(string)
    default     = []
}

variable "specific_routes_to_owner" {
    description = "The specific routes to Owner VPC through VPC peering connection."
    type = list(map(string))
    default = []
}

variable "tags" {
    description = "Map of tags to be assigned to Peering connection."
    type        = map(string)
    default     = {}
}