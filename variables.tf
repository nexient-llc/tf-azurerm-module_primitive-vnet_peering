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

variable "peering_name" {
  description = "Name of the virtual network peering"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the virtual network"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "remote_virtual_network_id" {
  description = "ID of the remote virtual network"
  type        = string
}

variable "allow_virtual_network_access" {
  description = "Controls if traffic is allowed from the remote virtual network to the local virtual network. Defaults to true."
  type        = bool
  default     = true
}

variable "allow_forwarded_traffic" {
  description = "Controls if forwarded traffic from the remote virtual network is allowed. Defaults to false."
  type        = bool
  default     = false
}

variable "allow_gateway_transit" {
  description = "Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network. Defaults to false."
  type        = bool
  default     = false
}

variable "use_remote_gateways" {
  description = "Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit is set to true, virtual network will use the remote gateways. Defaults to false."
  type        = bool
  default     = false
}
