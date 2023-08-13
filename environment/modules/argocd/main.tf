resource "helm_release" "argocd" {
 #depends_on = [kubectl_manifest.cert-manager-crds]
  repository = "oci://registry-1.docker.io/bitnamicharts"
  version    = "4.7.21"
  name       = "argo-cd"
  chart      = "argo-cd"
  #namespace  = "tekton-pipelines"
  #create_namespace = true
  
  # Bogus set to link together resources for proper tear down
  set {
    name = "server.ingress.enabled"
    value = "true"
  }

  set {
    name = "server.ingress.hostname"
    value = "rancher.rd.localhost"
  }
  #rancher.rd.localhost
  set {
    name = "server.ingress.tls"
    value = "true"
  }
  set {
    name = "server.ingress.selfSigned"
    value = "true"
  }
  set {
    name = "config.secret.argocdServerAdminPassword"
    value = "password"
  }
}


resource "kubectl_manifest" "test" {
    yaml_body = <<YAML
apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: traefik
  namespace: kube-system
spec:
  valuesContent: |-
    additionalArguments:
      - "--serverstransport.insecureskipverity=true"
YAML
}