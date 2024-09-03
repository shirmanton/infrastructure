terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_kubernetes_cluster" "kubernetes_cluster" {
  name = var.kubernetes_cluster

  network_id = "${yandex_vpc_network.vpc_network.id}"

  master {
    version = var.kubernetes_version
    zonal {
      zone      = "${yandex_vpc_subnet.vpc_subnet.zone}"
      subnet_id = "${yandex_vpc_subnet.vpc_subnet.id}"
    }

    public_ip = true

    maintenance_policy {
      auto_upgrade = true
    }

    master_logging {
      enabled = true
      log_group_id = "${yandex_logging_group.logging_group.id}"
      kube_apiserver_enabled = true
      cluster_autoscaler_enabled = true
      events_enabled = true
      audit_enabled = true
    }
  }

  service_account_id      = "${yandex_iam_service_account.iam_service_account.id}"
  node_service_account_id = "${yandex_iam_service_account.iam_service_account.id}"

  kms_provider {
    key_id = "${yandex_kms_symmetric_key.kms_symmetric_key.id}"
  }
}

resource "yandex_kms_symmetric_key" "kms_symmetric_key" {
  name = var.kms_symmetric_key
}

resource "yandex_iam_service_account" "iam_service_account" {
  name = var.iam_service_account
}

resource "yandex_resourcemanager_folder_iam_member" "admin" {
  folder_id = var.folder_id
  role      = "admin"
  member    = "serviceAccount:${yandex_iam_service_account.iam_service_account.id}"
}

resource "yandex_vpc_network" "vpc_network" {
  name = var.vpc_network
}

resource "yandex_vpc_subnet" "vpc_subnet" {
  name           = var.vpc_subnet
  zone           = var.zone
  network_id     = yandex_vpc_network.vpc_network.id
  v4_cidr_blocks = var.v4_cidr_block
}

resource "yandex_logging_group" "logging_group" {
  name      = var.logging_group
  folder_id = var.folder_id
}

# resource "helm_release" "argocd" {
#   depends_on = [yandex_kubernetes_cluster.kubernetes_cluster]

#   name       = "argocd"
#   repository = "https://argoproj.github.io/argo-helm"
#   chart      = "argo-cd"
#   version    = "7.5.2"

#   namespace = "argocd"

#   create_namespace = true
# }