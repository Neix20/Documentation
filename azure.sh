
# Login Using Azure Device Code
az login --use-device-code

# Check Azure Account List 
az account list --output table

# List All Existing Resource Groups
az group list --subscription <subscription-id>

# List all Azure Kubernetes Cluster
az aks list --output table

# Get Credentials
az aks get-credentials --resource-group <rg-name> --name <aks-cluster-name>
az aks get-credentials -g <rg-name> -n <aks-cluster-name>

# Set Current Context
kubectl config set-context <aks-cluster-name> --namespace=<aks-namespace>

