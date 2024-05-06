resource "kubernetes_namespace" "i" {
  metadata {
    name = var.chart_name
    labels = {
      app = var.chart_name
    }
  }
}

resource "helm_release" "i" {
  depends_on = [kubernetes_namespace.i]

  name      = var.chart_name
  namespace = kubernetes_namespace.i.metadata[0].name

  repository = var.chart_repo
  chart      = var.chart_name
  version    = var.chart_version

  cleanup_on_fail   = true
  dependency_update = true
  recreate_pods     = true

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "image.tag"
    value = "1.30.5"
  }

  set {
    name  = "persistence.size"
    value = "10Gi"
  }

  set {
    name  = "ingress.enabled"
    value = "false"
  }

  set {
    name  = "vaultwarden.domain"
    value = "https://${var.domain_name}"
  }

  set {
    name  = "vaultwarden.allowSignups"
    value = "false"
  }


  set {
    name  = "vaultwarden.admin.enabled"
    value = "true"
  }

  set_sensitive {
    name  = "vaultwarden.admin.token"
    value = var.admin_token
  }

}