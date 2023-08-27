resource "helm_release" "sonarqube" {
 #depends_on = [kubectl_manifest.cert-manager-crds]
  repository = "oci://registry-1.docker.io/bitnamicharts"
  version    = "3.2.8"
  name       = "sonarqube"
  chart      = "sonarqube"
  namespace  = "sonarqube"
  create_namespace = true
  
  # Bogus set to link together resources for proper tear down
  set {
    name = "ingress.enabled"
    value = "true"
  }

  set {
    name = "ingress.hostname"
    value = "sonar.rd.localhost"
  }
  #rancher.rd.localhost
  set {
    name = "ingress.tls"
    value = "true"
  }
  set {
    name = "ingress.selfSigned"
    value = "true"
  }
  set {
    name = "service.type"
    value = "ClusterIP"
  }
  set {
    name = "sonarqubePassword"
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
      - "--serverstransport.insecureskipverify=true"
YAML
}