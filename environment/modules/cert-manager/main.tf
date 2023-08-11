# data "http" "manifestfile" {
#   url = "https://github.com/cert-manager/cert-manager/releases/download/v1.12.2/cert-manager.crds.yaml"
# }


# resource "kubectl_manifest" "cert-manager-crds" {
#     yaml_body = data.http.manifestfile.response_body
# }




# install cert-manager
resource "helm_release" "cert_manager" {
 #depends_on = [kubectl_manifest.cert-manager-crds]
  repository = "https://charts.jetstack.io"
  version    = "v1.12.2"
  name       = "cert-manager"
  chart      = "cert-manager"
  namespace  = "cert-manager"
  create_namespace = true
  set {
    name  = "installCRDs"
    value = "true"
  }

  # Bogus set to link together resources for proper tear down
}