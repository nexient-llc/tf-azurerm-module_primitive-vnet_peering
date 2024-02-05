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

output "ids" {
  description = "The IDs of the VPC peering connection."
  value       = { for key, peering in module.vnet_peerings : key => peering.id }
}

output "names" {
  description = "The names of the VPC peering connection."
  value       = { for key, peering in module.vnet_peerings : key => peering.name }
}

output "resource_group_name" {
  value = module.resource_group.name
}

output "vnet_names" {
  value = module.vnets.vnet_names
}
