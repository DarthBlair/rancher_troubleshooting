resource "helm_release" "tekton" {
 #depends_on = [kubectl_manifest.cert-manager-crds]
  repository = "https://cdfoundation.github.io/tekton-helm-chart/"
  version    = "1.0.2"
  name       = "cdf"
  chart      = "tekton-pipeline"
  #namespace  = "tekton-pipelines"
  #create_namespace = true
  
  # Bogus set to link together resources for proper tear down
}