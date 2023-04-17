# Create a new rancher2 Project
resource "rancher2_project" "workshop_project_network_policies_1" {
  name = "Workshop Network Policies"
  cluster_id = var.cluster_id
}

resource "rancher2_namespace" "namespace1_network_policies" {
  name = "workshop-k3s-project-quotas-network-policies"
  project_id = rancher2_project.workshop_project_network_policies_1.id
  description = "Namespace for Troubleshooting with Network Policies"
}
