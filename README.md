# learn-terraform
Terraform playground

## Hashicorp tutorials
Follow the bouncing ball at https://learn.hashicorp.com/tutorials/terraform/azure-build?in=terraform/azure-get-started


## Goals

* setup storage account
* setup azure function
* setup static website
* PR to show plan
* two environments
* use github actions to deploy


## Remote State
Use script create-azure-tfstate.sh to create resourcegroup, storage account and container in azure, this is a once off script
TODO: create CMD/BAT or powershell equivalent

* look at workspaces to manage state of different environments

