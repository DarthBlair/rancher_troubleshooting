# Deployment 1

resource "kubernetes_deployment" "deployment1_missingquotas" {
  wait_for_rollout = false

  metadata {
    name = "k3s-workshop-project-quotas-deployment1"
    namespace = rancher2_namespace.namespace1_default_resource_quotas.name
    labels = {
      test = "deployment1"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "deployment1"
      }
    }

    template {
      metadata {
        labels = {
          test = "deployment1"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "webserver"

            /*
          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
          */

          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "deployment2_falsequotas" {
  wait_for_rollout = false
  metadata {
    name = "k3s-workshop-project-quotas-deployment2"
    namespace = rancher2_namespace.namespace2_specific_resource_quotas.name
    labels = {
      test = "deployment2"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "deployment2"
      }
    }

    template {
      metadata {
        labels = {
          test = "deployment2"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "webserver"

          resources {
            limits = {
              cpu    = "3"
              memory = "3000Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
          

          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}


resource "kubernetes_deployment" "deployment3_falsequotas" {
  wait_for_rollout = false
  metadata {
    name = "k3s-workshop-project-quotas-deployment3"
    namespace = rancher2_namespace.namespace3_unspecific_resource_quotas.name
    labels = {
      test = "deployment3"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "deployment3"
      }
    }

    template {
      metadata {
        labels = {
          test = "deployment3"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "webserver"

          resources {
            limits = {
              cpu    = "1500"
              memory = "1000Mi"
            }
            requests = {
              cpu    = "1500m"
              memory = "1000Mi"
            }
          }
          

          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}