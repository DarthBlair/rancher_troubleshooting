# resource "null_resource" "cert-manager-crds" {
#   provisioner "local-exec" {
#     command = <<EOF
# kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/v${var.certmanager_version}/deploy/manifests/00-crds.yaml
# kubectl create namespace cert-manager
# kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true
# EOF


#     environment = {
#       KUBECONFIG = local_file.kube_cluster_yaml.filename
#     }
#   }
# }

#kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.12.2/cert-manager.crds.yaml


# helm install rancher rancher-latest/rancher --namespace cattle-system --set hostname=rancher.rd.localhost --wait --timeout=10m
# install rancher
resource "helm_release" "rancher" {
  name      = "rancher"
  repository ="https://releases.rancher.com/server-charts/stable"
  chart     = "rancher"
  version   = "v2.6.12"
  namespace = "cattle-system"
  create_namespace = true
  timeout = "600"

  set {
    name  = "hostname"
    value = "rancher.rd.localhost"
  }

  set {
    name  = "bootstrapPassword"
    value = "P@ssw0rd"
  }

  # Bogus set to link togeather resources for proper tear down
  # set {
  #   name  = "tf_link"
  #   value = helm_release.cert_manager.name
  # }
}

# resource "null_resource" "wait_for_rancher" {
#   provisioner "local-exec" {
#     command = <<EOF
# while [ "$${subject}" != "*  subject: CN=$${RANCHER_HOSTNAME}" ]; do
#     subject=$(curl -vk -m 2 "https://$${RANCHER_HOSTNAME}/ping" 2>&1 | grep "subject:")
#     echo "Cert Subject Response: $${subject}"
#     if [ "$${subject}" != "*  subject: CN=$${RANCHER_HOSTNAME}" ]; then
#       sleep 10
#     fi
# done
# while [ "$${resp}" != "pong" ]; do
#     resp=$(curl -sSk -m 2 "https://$${RANCHER_HOSTNAME}/ping")
#     echo "Rancher Response: $${resp}"
#     if [ "$${resp}" != "pong" ]; then
#       sleep 10
#     fi
# done
# EOF


#     environment = {
#       RANCHER_HOSTNAME = "${local.name}.${local.domain}"
#       TF_LINK          = helm_release.rancher.name
#     }
#   }
# }