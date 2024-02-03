// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "resource_names" {
  source = "git::https://github.com/nexient-llc/tf-module-resource_name.git?ref=1.0.0"

  for_each = var.resource_names_map

  region                  = join("", split("-", each.value.region))
  class_env               = var.environment
  cloud_resource_type     = each.value.name
  instance_env            = var.environment_number
  instance_resource       = var.resource_number
  maximum_length          = each.value.max_length
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
}

module "resource_group" {
  source   = "git::https://github.com/nexient-llc/tf-azurerm-module-resource_group.git?ref=0.2.0"
  name     = module.resource_names["resource_group"].standard
  location = var.resource_names_map["resource_group"].region
  tags     = merge(var.tags, { resource_name = module.resource_names["resource_group"].standard })
}

module "vnets" {
  source = "git::https://github.com/nexient-llc/tf-azurerm-module_collection-virtual_network.git?ref=feature/update-from-primitive"

  network_map = { for name, vnet in var.network_map : name => merge(vnet, {
    resource_group_name = module.resource_names["resource_group"].standard
    location            = var.resource_names_map["resource_group"].region
    tags                = merge(var.tags, { resource_name = module.resource_names["resource_group"].standard })
  }) }

  depends_on = [module.resource_group]
}

module "vpc_peerings" {
  source = "../.."

  for_each = toset(keys(var.network_map))

  resource_group_name       = module.resource_group.name
  remote_virtual_network_id = module.vnets.vnet_ids[one(setsubtract(keys(var.network_map), [each.key]))]

  peering_name         = "${each.key}-to-${one(setsubtract(keys(var.network_map), [each.key]))}"
  virtual_network_name = module.vnets.vnet_names[each.key]
}
