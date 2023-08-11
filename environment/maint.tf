# module "cert-manager" {
#   source = "./modules/cert-manager"
# }

module "tekton" {
  source = "./modules/tekton"
}
module "argocd" {
  source = "./modules/argocd"
}