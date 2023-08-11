resource "helm_release" "backstage" {
 #depends_on = [kubectl_manifest.cert-manager-crds]
  repository = "https://backstage.github.io/charts"
  version    = "1.2.0"
  name       = "backstage"
  chart      = "backstage"
  namespace  = "backstage"
  create_namespace = true
  
  # Bogus set to link together resources for proper tear down
}