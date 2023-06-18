provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "wordpress" {
  metadata {
    name = "wordpress"
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

variable "wordpressUsername" {}
variable "wordpressPassword" {}
variable "mariadbPassword" {}

resource "helm_release" "wordpress" {
  name       = "myblog"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "wordpress"
  namespace  = kubernetes_namespace.wordpress.metadata[0].name

  set {
    name  = "persistence.storageClass"
    value = "default" 
  }

  set {
    name  = "persistence.accessMode"
    value = "ReadWriteOnce"
  }

  set {
    name  = "persistence.size"
    value = "16Gi"
  }

  set {
    name  = "mariadb.master.persistence.storageClass"
    value = "default"
  }

  set {
    name  = "mariadb.master.persistence.accessMode"
    value = "ReadWriteOnce"
  }

  set {
    name  = "mariadb.master.persistence.size"
    value = "8Gi"
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "wordpressUsername"
    value = var.wordpressUsername
  }

  set {
    name  = "wordpressPassword"
    value = var.wordpressPassword
  }

  set {
    name  = "mariadb.auth.rootPassword"
    value = var.mariadbPassword
  }
}

