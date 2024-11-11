# Login to AWS (You will need to configure AWS CLI with credentials)
aws configure

# Check AWS Account List (This step isn't directly available in AWS CLI, 
# but you can view the account details by listing your caller identity)
aws sts get-caller-identity

# List All Existing Resource Groups (AWS CLI does not have a direct command for resource groups like Azure,
# you can list by tags which represent resource groups)
aws resourcegroupstaggingapi get-resources

# List all Amazon EKS Clusters
aws eks list-clusters

# Get Credentials for a specific EKS cluster (this configures kubectl)
aws eks update-kubeconfig --name <eks-cluster-name> --region <region-name>
aws eks update-kubeconfig --name example --region us-east-1

# Set Current Context (kubectl command remains the same for AWS)
kubectl config set-context <eks-cluster-name> --namespace=<eks-namespace>

# Delete Current Context (kubectl command remains the same for AWS)
kubectl config delete-context <eks-cluster-name>

# Clear AWS Account Configuration
aws configure set aws_access_key_id ""
aws configure set aws_secret_access_key ""
