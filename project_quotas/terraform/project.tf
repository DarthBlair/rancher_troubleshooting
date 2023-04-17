# Create a new rancher2 Project
resource "rancher2_project" "workshop_project_quota_1" {
  name = "Workshop Project Quotas"
  cluster_id = var.cluster_id
  resource_quota {
    project_limit {
      limits_cpu = "3000m"
      limits_memory = "3000Mi"
      requests_storage = "2Gi"
    }
    namespace_default_limit {
      limits_cpu = "1000m"
      limits_memory = "500Mi"
      requests_storage = "0Gi"
    }
  }
  /*
  container_resource_limit {
    limits_cpu = "20m"
    limits_memory = "20Mi"
    requests_cpu = "1m"
    requests_memory = "1Mi"
  }
  */
}

resource "rancher2_namespace" "namespace1_default_resource_quotas" {
  name = "workshop-k3s-project-quotas-namespace1"
  project_id = rancher2_project.workshop_project_quota_1.id
  description = "Namespace for Troubleshooting with Project Quotas"
  /*
  resource_quota {
    limit {
      limits_cpu = "100m"
      limits_memory = "100Mi"
      requests_storage = "1Gi"
    }
  }
  */
  /*
  container_resource_limit {
    limits_cpu = "20m"
    limits_memory = "20Mi"
    requests_cpu = "1m"
    requests_memory = "1Mi"
  }*/
}


resource "rancher2_namespace" "namespace2_specific_resource_quotas" {
  name = "workshop-k3s-project-quotas-namespace2"
  project_id = rancher2_project.workshop_project_quota_1.id
  description = "Namespace for Troubleshooting with Project Quotas"
  
  resource_quota {
    limit {
      limits_cpu = "500m"
      limits_memory = "500Mi"
      requests_storage = "1Gi"
    }
  }
  
  /*
  container_resource_limit {
    limits_cpu = "20m"
    limits_memory = "20Mi"
    requests_cpu = "1m"
    requests_memory = "1Mi"
  }*/
}

resource "rancher2_namespace" "namespace3_unspecific_resource_quotas" {
  name = "workshop-k3s-project-quotas-namespace3"
  project_id = rancher2_project.workshop_project_quota_1.id
  description = "Namespace for Troubleshooting with Project Quotas"
  
  /*
  container_resource_limit {
    limits_cpu = "20m"
    limits_memory = "20Mi"
    requests_cpu = "1m"
    requests_memory = "1Mi"
  }*/
}