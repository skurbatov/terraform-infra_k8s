locals {
  vapp             = local.env
  env              = "bestapp_k8s-stend01"
  env_short        = "ba01"
  vm_network       = var.vcd_network
  net              = "172.16.0"
  template         = "CentOS Steam 8 Minimal EFI"
  os_type          = "centos8_64Guest"
  annotation = "${var.GIT_USER_EMAIL}\n${var.GIT_USER_NAME}\n${var.CI_PROJECT_URL}\n${var.CI_PIPELINE_URL}"
}

## Create vApp for project VM

resource "vcd_vapp" "vapp" {
  name = local.vapp

  metadata = {
    vapp_annotation = local.annotation
  }
}

resource "vcd_vapp_org_network" "vapp_direct-network" {
  vapp_name        = vcd_vapp.vapp.name
  org_network_name = local.vm_network

  depends_on = [vcd_vapp.vapp]
}

###################################################################################
####                            infra-k8s-master                               ####
###################################################################################
module "ba01-k8s-master" {
  source = "git@github.com:skurbatov/terrafrom-module_vcloud_vapp.git?ref=1.0.0"
  template = local.template
  os_type  = local.os_type
  count = "3"
  vm_name = "${local.env_short}-k8s-master-${count.index + 1}"
  net = "${local.vm_network}"
  ip = "${local.net}.2${count.index + 1}"
  vapp             = local.vapp
  ram              = 8192
  num_cpu          = 4
  num_core_cpu     = 2
  disk_size        = 71680

  depends_on = [vcd_vapp_org_network.vapp_direct-network]
}

# ###################################################################################
# ####                           infra-k8s-ingress                               ####
# ###################################################################################
module "ba01-k8s-ingress" {
  source = "git@github.com:skurbatov/terrafrom-module_vcloud_vapp.git?ref=1.0.0"
  template = local.template
  os_type  = local.os_type
  count = "2"
  vm_name = "${local.env_short}-ingress0${count.index + 1}"
  net = "${local.vm_network}"
  ip = "${local.net}.1${count.index + 1}"
  vapp             = local.vapp
  ram              = 4096
  num_cpu          = 2
  num_core_cpu     = 2
  disk_size        = 71680

  depends_on = [vcd_vapp_org_network.vapp_direct-network]
}

# ###################################################################################
# ####                           infra-k8s-worker                                ####
# ###################################################################################
module "ba01-k8s-worker" {
  source = "git@github.com:skurbatov/terrafrom-module_vcloud_vapp.git?ref=1.0.0"
  template = local.template
  os_type  = local.os_type
  count = "6"
  vm_name = "${local.env_short}-k8s-worker-a0${count.index + 1}"
  net = "${local.vm_network}"
  ip = "${local.net}.3${count.index + 1}"
  vapp             = local.vapp
  ram              = 10240
  num_cpu          = 8
  num_core_cpu     = 2
  disk_size        = 71680

  depends_on = [vcd_vapp_org_network.vapp_direct-network]
}

# ###################################################################################
# ####                              infra-k8s-nfs                                ####
# ###################################################################################
module "ba01-k8s-nfs" {
  source = "git@github.com:skurbatov/terrafrom-module_vcloud_vapp.git?ref=1.0.0"
  template = local.template
  os_type  = local.os_type
  count = "1"
  vm_name = "${local.env_short}-nfs0${count.index + 1}"
  net = "${local.vm_network}"
  ip = "${local.net}.4${count.index + 1}"
  vapp             = local.vapp
  ram              = 8192
  num_cpu          = 4
  num_core_cpu     = 2
  disk_size        = 71680

  depends_on = [vcd_vapp_org_network.vapp_direct-network]
}
