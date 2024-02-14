logical_product_family  = "dso"
logical_product_service = "vnetpeer"

network_map = {
  "vnet1" = {
    vnet_name                                             = "vnet-test-800"
    address_space                                         = ["10.10.0.0/16"]
    subnet_names                                          = ["subnet-1"]
    subnet_prefixes                                       = ["10.10.0.0/24"]
    bgp_community                                         = null
    ddos_protection_plan                                  = null
    dns_servers                                           = []
    nsg_ids                                               = {}
    route_tables_ids                                      = {}
    subnet_delegation                                     = {}
    subnet_enforce_private_link_endpoint_network_policies = {}
    subnet_enforce_private_link_service_network_policies  = {}
    subnet_service_endpoints                              = {}
    tags                                                  = {}
    tracing_tags_enabled                                  = false
    tracing_tags_prefix                                   = ""
    use_for_each                                          = true
  }
  "vnet2" = {
    vnet_name                                             = "vnet-test-801"
    address_space                                         = ["10.11.0.0/16"]
    subnet_names                                          = ["subnet-1"]
    subnet_prefixes                                       = ["10.11.0.0/24"]
    bgp_community                                         = null
    ddos_protection_plan                                  = null
    dns_servers                                           = []
    nsg_ids                                               = {}
    route_tables_ids                                      = {}
    subnet_delegation                                     = {}
    subnet_enforce_private_link_endpoint_network_policies = {}
    subnet_enforce_private_link_service_network_policies  = {}
    subnet_service_endpoints                              = {}
    tags                                                  = {}
    tracing_tags_enabled                                  = false
    tracing_tags_prefix                                   = ""
    use_for_each                                          = true
  }
}

tags = {
  provisioner = "Terraform"
  purpose     = "VNET Peering Terratest"
}
