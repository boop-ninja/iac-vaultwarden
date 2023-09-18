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

  set_sensitive {
    name  = "env.ADMIN_TOKEN"
    value = var.admin_token
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "image.tag"
    value = "1.29.2"
  }

  set {
    name  = "persistence.size"
    value = "10Gi"
  }

  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set_sensitive {
    name  = "ingress.host"
    value = "https://${var.domain_name}"
  }

  set {
    name  = "admin.enabled"
    value = "true"
  }

  set {
    name  = "vaultwarden.allowSignups"
    value = "false"
  }




  # set {
  #   name  = "bitwardenrs.smtp.enabled"
  #   value = "true"
  # }
  # set {
  #   name  = "bitwardenrs.smtp.from"
  #   value = "no-reply@${var.domain_name}"
  # }
  # set {
  #   name  = "bitwardenrs.smtp.fromName"
  #   value = "BitWarden"
  # }
  # set {
  #   name  = "bitwardenrs.smtp.host"
  #   value = var.smtp_host
  # }
  # set_sensitive {
  #   name  = "bitwardenrs.smtp.user"
  #   value = var.smtp_user
  # }
  # set_sensitive {
  #   name  = "bitwardenrs.smtp.password"
  #   value = var.smtp_password
  # }
  # set_sensitive {
  #   name  = "env.SMTP_USERNAME"
  #   value = var.smtp_user
  # }
  # set_sensitive {
  #   name  = "env.SMTP_PASSWORD"
  #   value = var.smtp_password
  # }
}