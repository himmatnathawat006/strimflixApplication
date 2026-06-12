#!/bin/bash
set -e

echo "=== Starting Post-Deployment Validation ==="

# 1. Retrieve Terraform outputs
echo "Retrieving Terraform outputs..."
RESOURCE_GROUP=$(terraform output -raw resource_group_name 2>/dev/null || echo "Himmat-RG")
AKS_CLUSTER=$(terraform output -raw aks_cluster_name 2>/dev/null || echo "aks-streamflix-dev")
ACR_LOGIN_SERVER=$(terraform output -raw acr_login_server 2>/dev/null || echo "")
KEYVAULT_URI=$(terraform output -raw keyvault_uri 2>/dev/null || echo "")

ACR_NAME=$(echo "$ACR_LOGIN_SERVER" | cut -d'.' -f1)
KEYVAULT_NAME=$(echo "$KEYVAULT_URI" | cut -d'/' -f3 | cut -d'.' -f1)

echo "Resource Group: $RESOURCE_GROUP"
echo "AKS Cluster: $AKS_CLUSTER"
echo "ACR Name: $ACR_NAME"
echo "Key Vault Name: $KEYVAULT_NAME"

# 2. Verify Resource Group
echo "Checking Resource Group existence..."
if az group show --name "$RESOURCE_GROUP" >/dev/null 2>&1; then
    echo "✔ Resource Group '$RESOURCE_GROUP' exists."
else
    echo "✘ Resource Group '$RESOURCE_GROUP' not found!"
    exit 1
fi

# 3. Verify ACR
if [ -n "$ACR_NAME" ]; then
    echo "Checking Azure Container Registry status..."
    if az acr show --name "$ACR_NAME" --resource-group "$RESOURCE_GROUP" >/dev/null 2>&1; then
        echo "✔ ACR '$ACR_NAME' is active."
    else
        echo "✘ ACR '$ACR_NAME' not found or inactive!"
        exit 1
    fi
fi

# 4. Verify AKS Cluster
echo "Checking AKS Cluster status..."
if az aks show --name "$AKS_CLUSTER" --resource-group "$RESOURCE_GROUP" --query "provisioningState" -o tsv | grep -q "Succeeded"; then
    echo "✔ AKS Cluster '$AKS_CLUSTER' is running and active."
else
    echo "✘ AKS Cluster '$AKS_CLUSTER' is not in Succeeded state!"
    exit 1
fi

# 5. Verify Key Vault
if [ -n "$KEYVAULT_NAME" ]; then
    echo "Checking Key Vault status..."
    if az keyvault show --name "$KEYVAULT_NAME" --resource-group "$RESOURCE_GROUP" >/dev/null 2>&1; then
        echo "✔ Key Vault '$KEYVAULT_NAME' is active."
    else
        echo "✘ Key Vault '$KEYVAULT_NAME' not found or inactive!"
        exit 1
    fi
fi

echo "=== Post-Deployment Validation PASSED successfully ==="
