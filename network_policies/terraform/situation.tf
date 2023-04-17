# Deployment 1

resource "kubernetes_deployment" "deployment1_networkpolicies" {
  wait_for_rollout = false

  metadata {
    name = "k3s-workshop-networkpolicies-deployment1"
    namespace = rancher2_namespace.namespace1_network_policies.name
    labels = {
        test = "deployment1_np"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "deployment1_np"
      }
    }

    template {
      metadata {
        labels = {
          test = "deployment1_np"
        }
      }

      spec {
        container {
          image = "nginx:1.21.6"
          name  = "webserver"

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

#kubernetes-service-network-policies.workshopk3s-project-quotas-network-policies.svc.cluster.local

resource "kubernetes_service" "kubernetes_service_network_policy_service" {
  metadata {
    name = "kubernetes-service-network-policies"
    namespace = rancher2_namespace.namespace1_network_policies.name
  }
  spec {
    selector = {
      test = "deployment1_np"
    }

    session_affinity = "ClientIP"
    port {
      port        = 8080
      target_port = 80
    }

    type = "NodePort"
  }
}
#kubernetes-service-network-policies.workshopk3s-project-quotas-network-policies.svc.cluster.local

// Deny All Network Policy
resource "kubernetes_network_policy" "network_policy" {
  metadata {
    name      = "terraform-network-policy-situation-1"
    namespace = rancher2_namespace.namespace1_network_policies.name
  }

  spec {
    pod_selector {
      match_labels = {
        test = "deployment1_np"
      }
    }

    ingress {
      from {
        pod_selector {
          match_labels = {
            app = "backend"
          }
        }
      }
    }
        
    policy_types = ["Ingress"]
  }
}

# Calling Deployment
resource "kubernetes_deployment" "deployment2_caller" {
  wait_for_rollout = false

  metadata {
    name = "k3s-workshop-networkpolicies-deployment2"
    namespace = rancher2_namespace.namespace1_network_policies.name
    labels = {
        app = "deployment1_caller"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "deployment1_np"
      }
    }

    template {
      metadata {
        labels = {
          test = "deployment1_np"
        }
      }

      spec {
          container {
            name    = "networktest"
            image   = "busybox"
            command = ["/bin/sh", "-c", "wget -O- kubernetes-service-network-policies.workshopk3s-project-quotas-network-policies.svc.cluster.local:8080"]
          }
        }
      }
    }
}


#kubernetes-service-network-policies.workshopk3s-project-quotas-network-policies.svc.cluster.local:8080