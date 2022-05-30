#!/bin/bash

RESOURCE_GROUP_NAME=learn-terraform-tfstate-rg
STORAGE_ACCOUNT_NAME=lodevtf01
CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location "Australia Central"

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

# list account keys: az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv
# store the key in keyvault
KEY_NAME=learn-terraform-backend-key
KEY_VAULT_NAME=CodingSecrets
export ARM_ACCESS_KEY=$(az keyvault secret show --name $KEY_NAME --vault-name $KEY_VAULT_NAME  --query value -o tsv)