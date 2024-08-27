
# Check Azure Account List 
az account list --output table

# List All Existing Resource Groups
az group list --subscription <subscription-id>
az group list --subscription 85d3379c-2a11-4b41-b33f-d61218b89b33

# List all Azure Kubernetes Cluster
az aks list --output table

# Get Credentials
az aks get-credentials --resource-group <rg-name> --name <aks-cluster-name>
az aks get-credentials -g <rg-name> -n <aks-cluster-name>
az aks get-credentials -g rg-ts01-eas-n-devops -n aks-ts01-eas-n-share01 --overwrite-existing

# Set Current Context
kubectl config set-context aks-ts01-eas-n-share01 --namespace=nsp-ts01-d-dcepoc
