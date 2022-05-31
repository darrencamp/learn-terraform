# learn-terraform
Terraform playground

## Hashicorp tutorials
Follow the bouncing ball at https://learn.hashicorp.com/tutorials/terraform/azure-build?in=terraform/azure-get-started

create service principal
`az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<subscription-id>"`

should output something like:
{
  "appId": "GUI",
  "displayName": "a display name",
  "password": "a password",
  "tenant": "GUID"
}

mappings:
appid -> clientId
password -> clientSecret
tenant -> tenantId

with the above, set the following:
ARM_CLIENT_ID=clientId
ARM_CLIENT_SECRET=clientSecret
ARM_SUBSCRIPTION_ID=<subscription-id>
ARM_TENANT_ID=tenantId

also set the 

ARM_ACCESS_KEY for state storage
list account keys: `az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv`
show secret: `az keyvault secret show --name $KEY_NAME --vault-name $KEY_VAULT_NAME  --query value -o tsv`

manually store the access key in keyvault
`export ARM_ACCESS_KEY=$(az keyvault secret show --name $KEY_NAME --vault-name $KEY_VAULT_NAME  --query value -o tsv)`

## Goals

- [X] setup storage account
- [] setup azure function
- [] setup static website
- [X] PR to show plan
- [] two environments
- [X] use github actions to deploy
- [] Same in Azure DevOps

## Remote State
Use script create-azure-tfstate.sh to create resourcegroup, storage account and container in azure, this is a once off script
TODO: create CMD/BAT or powershell equivalent

- look at workspaces to manage state of different environments

## Setting up github actions
refer: https://github.com/Azure/actions-workflow-samples/blob/master/assets/create-secrets-for-GitHub-workflows.md
```

   az ad sp create-for-rbac --name "myApp" --role contributor \
                            --scopes /subscriptions/{subscription-id} \
                            --sdk-auth
                            
  # Replace {subscription-id}, {resource-group} with the subscription, resource group details

  # The command should output a JSON object similar to this:

  {
    "clientId": "<GUID>",
    "clientSecret": "<GUID>",
    "subscriptionId": "<GUID>",
    "tenantId": "<GUID>",
    (...)
  }
```

- Create secret in github called `AZURE_CREDENTIALS` which has a value of the JSON output of the principal creation command above
- setup secrets for client id, client secret, subscription and tenant
- make sure the service princpal has access to the keyvault get, list permissions ie `az keyvault set-policy -n {keyVaultName} --secret-permissions get list --spn {clientIdGUID}`

## Github actions tips
- workflow_dispatch = manually run workflow