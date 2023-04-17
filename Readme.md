# Troubleshooting-Exercise Repository
This repository contains troubleshooting exercises for k3s workshops.

## Prerequisites
1. You need an installed Rancher-Environment (If you do not have one yet, set-it-up in 5 minutes following this documentation: https://ranchermanager.docs.rancher.com/v2.5/pages-for-subheaders/rancher-on-a-single-node-with-docker)
Shortcut: `
docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  --privileged \
  rancher/rancher:latest
`
=> Open localhost:80 and configure your Rancher, Setup & Save API-Keys for later.
2. You need a configured kubeconfig-File in your ~/.kube/config - Directory
3. The configured kubeconfig-connection should be in context "local" => If your context-name changes, you can configure the context in the provider.tf-Files


## Setup Enviornment
1. In the corresponding folders, you need to fill the ".tfvars"-Variables
=> For that you need to configure the variables for the rancher host, rancher access- & secret-key and the cluster_id. For the cluster_id the "local" cluster is used by default

2. Execute correspondig terraform scripts, for each folder execute: 
`
terraform init
terraform plan --var-file="your-var-file.tfvars"
terraform apply --var-file="your-var-file.tfvars"

## Troubleshoot in the Workspaces that are generated