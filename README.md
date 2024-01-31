# Infra as code GC

## Overview

In this repository will be stored the terraform code to deploy the necessary components for demo purposes of deploying an Internal Developer Plataform using [backstage](https://backstage.spotify.com/) and [ArgoCD](https://argo-cd.readthedocs.io/en/stable/). For that the following components will be created in Google Cloud:

- Google Compute Network with a set of subnetworks
- 3 Google Compute Subnetworks
  - In one it will be created two secondary IP ranges to be used by GKE cluster for IP pod range and IP services range
- A GKE cluster in the goole compute network created that will be located in the Google Compute Subnetwork where the specific secondary IP ranges for services and pod where configured

## Configure access to GKE cluster

### Prerequisites

1. Install [gcloud](https://cloud.google.com/sdk/docs/install)
2. Install [gke-gcloud-auth-plugin](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl#install_plugin)

### Add cluster to kubeconfig

To add the GKE cluster to the kubeconfig is necessary run the following command:

```bash
gcloud container clusters get-credentials "idp-demo-kcd" \
  --region="us-central1"
```

## Infrastructure management commands

### Create infrastructure

To create the infrastructure is necessary run the following commands:

```bash
terraform -chdir=./src plan --var-file=terraform.tfvars --var-file=terraform_secrets.tfvars -out terraform.plan
terraform -chdir=./src apply "terraform.plan"
```

### Delete infrastructure

To delete the infrastructure is necessary run the following commands:

```bash
terraform -chdir=./src plan -destroy --var-file=terraform.tfvars --var-file=terraform_secrets.tfvars -out terraform.destroy
terraform -chdir=./src apply "terraform.destroy"
```
