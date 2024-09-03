variable "folder_id" { # Change to pre-created folder_id
  type    = string
  default = "b1ga2d5rb0nq4tqr3ej1"
}

variable "image_id" {
  type    = string
  default = "fd8pfoao3dut30gc5hjg" # ubuntu-22-04-lts-v20240902
}

variable "zone" {
  type    = string
  default = "ru-central1-a"
}

variable "platform_id" {
  type    = string
  default = "standard-v1"
}

variable "v4_cidr_block" {
  type    = list(string)
  default = ["10.120.0.0/16"]
}

variable "kubernetes_version" {
  type    = string
  default = "1.30"
}

variable "cores" {
  type    = number
  default = 4
}

variable "memory" {
  type    = number
  default = 4
}

variable "disk_size" {
  type    = number
  default = 50
}

variable "nat" {
  type    = bool
  default = true
}

variable "resourcemanager_folder" {
  type    = string
  default = "catalog-robot"
}

variable "vpc_address" {
  type    = string
  default = "address-robot"
}

variable "vpc_network" {
  type    = string
  default = "vpc-network-robot"
}

variable "vpc_subnet" {
  type    = string
  default = "vpc-subnet-robot"
}

variable "iam_service_account" {
  type    = string
  default = "sa-robot"
}

variable "compute_instance" {
  type    = string
  default = "vm-robot"
}

variable "compute_disk" {
  type    = string
  default = "disk-robot"
}

variable "logging_group" {
  type    = string
  default = "logging-group-robot"
}

variable "kms_symmetric_key" {
  type    = string
  default = "kms-symmetric-key-robot"
}

variable "kubernetes_cluster" {
  type    = string
  default = "kubernetes-cluster-robot"
}