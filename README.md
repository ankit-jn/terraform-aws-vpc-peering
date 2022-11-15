## ARJ-Stack: AWS VPC Peering Terraform module

A Terraform module for setting up VPC peering between two VPCs that enables to route traffic between them.

### Resources

This module features the following components to be provisioned with different combinations:

- VPC Peering Connection [[aws_vpc_peering_connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection)]
- VPC Peering Connection Accepter [[aws_vpc_peering_connection_accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter)]
- VPC Peering COnnection Option [[aws_vpc_peering_connection_options](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_options)]
    - For VPC Peering Connection Requester
    - For VPC Peering Connection Accepter
- Route [[aws_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)]

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.22.0 |

### Examples

Refer [Configuration Examples](https://github.com/arjstack/terraform-aws-examples/tree/main/aws-vpc-peering) for effectively utilizing this module.

### Inputs
---

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="vpc_peering_connection_handler"></a> [vpc_peering_connection_handler](#input\_vpc\_peering\_connection\_handler) | Peering Connection Handler. | `string` | `"both"` | no |  |
| <a name="owner_account_id"></a> [owner_account_id](#input\_owner\_account\_id) | The AWS account ID of the owner of the peer VPC. | `string` | `null` | no |  |
| <a name="owner_vpc_id"></a> [owner_vpc_id](#input\_owner\_vpc\_id) | The ID of the owner VPC. | `string` |  | yes |  |
| <a name="peer_vpc_id"></a> [peer_vpc_id](#input\_peer\_vpc\_id) | The ID of the VPC with which you are creating the VPC Peering Connection. | `string` |  | yes |  |
| <a name="peer_vpc_region"></a> [peer_vpc_region](#input\_peer\_vpc\_region) | The region of the Peer VPC of the VPC Peering Connection. | `string` | `null` | no |  |
| <a name="peering_connection_id"></a> [peering_connection_id](#input\_peering\_connection\_id) | VPC Peering Connection ID. Required if `vpc_peering_connection_handler` is set as `peer` | `string` | `null` | no |  |
| <a name="auto_accept_peering"></a> [auto_accept_peering](#input\_auto\_accept\_peering) | Flag to decide if peering request should be accepted. | `bool` | `false` | no |  |
| <a name="allow_owner_vpc_dns_resolution"></a> [allow_owner_vpc_dns_resolution](#input\_allow\_owner\_vpc\_dns\_resolution) | Flag to decide if allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC. | `bool` | `false` | no |  |
| <a name="allow_peer_vpc_dns_resolution"></a> [allow_peer_vpc_dns_resolution](#input\_allow\_peer\_vpc\_dns\_resolution) | Flag to decide if allow a local VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the peer VPC. | `bool` | `false` | no |  |
| <a name="generalize_routes_to_peer"></a> [generalize_routes_to_peer](#input\_generalize\_routes\_to\_peer) | Flag to decide if Routes to `peer_cidrs` should be set in all Owner VPC's route tables. | `bool` | `false` | no |  |
| <a name="peer_cidrs"></a> [peer_cidrs](#input\_peer\_cidrs) | The list of CIDRs for which routes should be created in all Owner VPC's route tables. | `list(string)` | `[]` | no |  |
| <a name="specific_routes_to_peer"></a> [specific_routes_to_peer](#input\_specific\_routes\_to\_peer) | The specific routes to Peer VPC through VPC peering connection. | `list(map(string))` | `[]` | no |  |
| <a name="generalize_routes_to_owner"></a> [generalize_routes_to_owner](#input\_generalize\_routes\_to\_owner) | Flag to decide if Routes to `owner_cidrs` should be set in all Peer VPC's route tables. | `bool` | `false` | no |  |
| <a name="owner_cidrs"></a> [owner_cidrs](#input\_owner\_cidrs) | The list of CIDRs for which routes should be created in all Peer VPC's route tables. | `list(string)` | `[]` | no |  |
| <a name="specific_routes_to_owner"></a> [specific_routes_to_owner](#input\_specific\_routes\_to\_owner) | The specific routes to Owner VPC through VPC peering connection. | `list(map(string))` | `[]` | no |  |
| <a name="tags"></a> [tags](#input\_tags) | Map of tags to be assigned to Peering connection. | `map(string)` | `{}` | no |  |


- It required 2 alias AWS Providers, one for Connection Requester and other for Connection Accepter.

```
providers = {
    aws.owner = <provider for Requester>
    aws.peer = <provider for Accepter>
}
```

### Outputs

| Name | Type | Description |
|:------|:------|:------|
| <a name="id"></a> [id](#output\_id) | The ID of the VPC Peering Connection. | `string` | 
| <a name="status"></a> [status](#output\_status) | The status of the VPC Peering Connection request. | `string` | 
| <a name="owner_connection_option"></a> [owner_connection_option](#output\_owner\_connection\_option) | The ID of the VPC Peering Connection Owner Option. | `string` | 
| <a name="peer_connection_option"></a> [peer_connection_option](#output\_peer\_connection\_option) | The ID of the VPC Peering Connection Peer Option. | `string` | 

### Authors

Module is maintained by [Ankit Jain](https://github.com/ankit-jn) with help from [these professional](https://github.com/arjstack/terraform-aws-vpc-peering/graphs/contributors).
