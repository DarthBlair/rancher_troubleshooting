/*

apiVersion: batch/v1
kind: CronJob
metadata:
  name: reference
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: reference
            image: busybox
            imagePullPolicy: IfNotPresent
            command:
            - /bin/sh
            - -c
            - date; echo Hello from the Kubernetes cluster; cd /mnt/c/Users/path_to_folder;wget {url}
          restartPolicy: OnFailure

*/



# CronJob
resource "kubernetes_cron_job" "cronjob-network-policies" {
  metadata {
    name = "cronjob-network-policies"
    namespace = rancher2_namespace.namespace1_network_policies.name
  }
  spec {
#    concurrency_policy            = "Replace"
    failed_jobs_history_limit     = 5
    schedule =  "*/1 * * * *"
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 10
    job_template {
      metadata {}
      spec {
        backoff_limit              = 2
        ttl_seconds_after_finished = 10
        template {
          metadata {}
          spec {
            container {
              name    = "networktest"
              image   = "busybox"
              command = ["/bin/sh", "-c", "wget -O- "]
            }
          }
        }
      }
    }
  }
}

