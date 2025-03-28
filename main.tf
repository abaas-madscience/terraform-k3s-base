terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.0"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

module "base_image" {
  source           = "./modules/base_image"
  base_image_url   = "file://./images/golden-arch.raw"
  base_image_path  = "./images/golden-arch.raw"
  pool_name        = var.pool_name
}

module "control_node" {
  source = "./modules/control_node"
  base_volume_id = module.base_image.base_volume_id
  pool_name = var.pool_name
  ssh_key_path = var.ssh_key_path
  ssh_authorized_path = var.ssh_authorized_path
  network_config = {
    ip_address = "192.168.178.100/24"
    gateway = "192.168.178.1"
    dns_servers = ["192.168.178.2"]
  }
}

module "worker_nodes" {
  source = "./modules/worker_node"
  base_volume_id = module.base_image.base_volume_id
  pool_name = var.pool_name
  ssh_key_path = var.ssh_key_path
  ssh_authorized_path = var.ssh_authorized_path
  workers = var.workers
  network_config = {
    gateway = "192.168.178.1"
    dns_servers = ["192.168.178.2"]
  }
}