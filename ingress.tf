resource "kubernetes_ingress_v1" "i" {
  depends_on = [helm_release.i]

  metadata {
    name      = var.chart_name
    namespace = var.chart_name
    annotations = {
      "cert-manager.io/cluster-issuer" = "boop-ninja"
      "kubernetes.io/ingress.class"    = "traefik"
    }
  }

  spec {
    rule {
      host = var.domain_name
      http {
        path {
          backend {
            service {
              name = var.chart_name
              port {
                number = 80
              }
            }
          }

          path = "/"
        }

        path {
          backend {
            service {
              name = var.chart_name
              port {
                number = 3012
              }
            }
          }

          path = "/notifications/hub"
        }
      }
    }

    tls {
      hosts = [
        var.domain_name
      ]
      secret_name = "${var.chart_name}-tls"
    }
  }
}
