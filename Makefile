##
# Infra as code Google Cloud IDP demo
#
# @file
# @version 0.1
.PHONY: $(MAKECMDGOALS) build
.DEFAULT_GOAL := help

GOOGLE_PROJECT_ID=${{__GOOGLE_PROJECT_ID__}}

##@ General

# The help target prints out all targets with their descriptions organized
# beneath their categories. The categories are represented by '##@' and the
# target descriptions by '##'. The awk commands is responsible for reading the
# entire set of makefiles included in this invocation, looking for lines of the
# file as xyz: ## something, and then pretty-format the target and help. Then,
# if there's a line with ##@ something, that gets pretty-printed as a category.
# More info on the usage of ANSI control characters for terminal formatting:
# https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters
# More info on the awk command:
# http://linuxcommand.org/lc3_adv_awk.php

help: 						## Display this help.
	@printf -- "${FORMATTING_BEGIN_BLUE} ${GOOGLE_PROJECT_ID} ${FORMATTING_END}\n"
	@printf -- "\n"
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

build: lint audit docs 			## Run checks

##@ GKE - Infrastructure management
gke-init: ## Init terraform
	@terraform -chdir=./gke init

gke-plan: ## Generate terraform plan
	@terraform -chdir=./gke plan --var-file=terraform.tfvars --var-file=terraform_secrets.tfvars -out gke.plan

gke-apply: ## Apply terraform changes
	@terraform -chdir=./gke apply gke.plan

gke-plan-destroy:	## Generate plan for destroy files
	@terraform -chdir=./gke plan -destroy --var-file=terraform.tfvars --var-file=terraform_secrets.tfvars -out gke.destroy

gke-destroy:	gke-plan-destroy ## Destroy terraform changes
	@terraform -chdir=./gke apply gke.destroy

##@ ArgoCD - Infrastructure management
argocd-init: ## Init terraform
	@terraform -chdir=./argocd init

argocd-plan: ## Generate terraform plan
	@terraform -chdir=./argocd plan --var-file=terraform.tfvars --var-file=terraform_secrets.tfvars -out argocd.plan

argocd-apply: ## Apply terraform changes
	@terraform -chdir=./argocd apply argocd.plan

argocd-plan-destroy:	## Generate plan for destroy files
	@terraform -chdir=./argocd plan -destroy --var-file=terraform.tfvars --var-file=terraform_secrets.tfvars -out argocd.destroy

argocd-destroy:	argocd-plan-destroy ## Destroy terraform changes
	@terraform -chdir=./src apply argocd.destroy

##@ Backstage - Infrastructure management
backstage-init: ## Init terraform
	@terraform -chdir=./backstage init

backstage-plan: ## Generate terraform plan
	@terraform -chdir=./backstage plan --var-file=terraform.tfvars --var-file=terraform_secrets.tfvars -out backstage.plan

backstage-apply: ## Apply terraform changes
	@terraform -chdir=./backstage apply backstage.plan

backstage-plan-destroy:	## Generate plan for destroy files
	@terraform -chdir=./backstage plan -destroy --var-file=terraform.tfvars --var-file=terraform_secrets.tfvars -out backstage.destroy

backstage-destroy:	backstage-plan-destroy ## Destroy terraform changes
	@terraform -chdir=./src apply backstage.destroy

##@ Development
lint:	## format terraform code
	@terraform fmt

audit: 	## terraform static analysis
	@tfsec

docs:	## document module with terraform-docs
	@terraform-docs

##@ Google Cloud
connect-gke:	## Connect to GKE cluster
	@gcloud container clusters get-credentials idp --region europe-west1 --project $(GOOGLE_PROJECT_ID)
# end