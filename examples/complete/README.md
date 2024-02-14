# Complete example

This example creates two Virtual Networks in the same Resource Group and then creates a VPC peering between them.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0, <= 1.5.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.67.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | git::https://github.com/nexient-llc/tf-module-resource_name.git | 1.0.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | git::https://github.com/nexient-llc/tf-azurerm-module_primitive-resource_group.git | 0.2.0 |
| <a name="module_vnets"></a> [vnets](#module\_vnets) | git::https://github.com/nexient-llc/tf-azurerm-module_collection-virtual_network.git | 0.2.0 |
| <a name="module_vnet_peerings"></a> [vnet\_peerings](#module\_vnet\_peerings) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network_map"></a> [network\_map](#input\_network\_map) | Map of spoke networks where vnet name is key, and value is object containing attributes to create a network | <pre>map(object({<br>    resource_group_name = optional(string)<br>    location            = optional(string)<br>    vnet_name           = optional(string)<br>    address_space       = list(string)<br>    subnet_names        = list(string)<br>    subnet_prefixes     = list(string)<br>    bgp_community       = string<br>    ddos_protection_plan = object(<br>      {<br>        enable = bool<br>        id     = string<br>      }<br>    )<br>    dns_servers                                           = list(string)<br>    nsg_ids                                               = map(string)<br>    route_tables_ids                                      = map(string)<br>    subnet_delegation                                     = map(map(any))<br>    subnet_enforce_private_link_endpoint_network_policies = map(bool)<br>    subnet_enforce_private_link_service_network_policies  = map(bool)<br>    subnet_service_endpoints                              = map(list(string))<br>    tags                                                  = map(string)<br>    tracing_tags_enabled                                  = bool<br>    tracing_tags_prefix                                   = string<br>    use_for_each                                          = bool<br>  }))</pre> | n/a | yes |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-module-resource\_name to generate resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>    region     = optional(string, "eastus2")<br>  }))</pre> | <pre>{<br>  "resource_group": {<br>    "max_length": 80,<br>    "name": "rg",<br>    "region": "eastus"<br>  },<br>  "vpc_peering": {<br>    "max_length": 80,<br>    "name": "peer",<br>    "region": "eastus"<br>  }<br>}</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | `"dev"` | no |
| <a name="input_environment_number"></a> [environment\_number](#input\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 | `string` | `"001"` | no |
| <a name="input_resource_number"></a> [resource\_number](#input\_resource\_number) | The resource count for the respective resource. Defaults to 000. Increments in value of 1 | `string` | `"001"` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"network"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ids"></a> [ids](#output\_ids) | The IDs of the VPC peering connection. |
| <a name="output_names"></a> [names](#output\_names) | The names of the VPC peering connection. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_vnet_names"></a> [vnet\_names](#output\_vnet\_names) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
