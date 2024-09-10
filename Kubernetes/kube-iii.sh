# Add Kubernetes Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

# Apply Deployment
kubectl apply -f deploy.yml

# Apply Service, it can be ClusterIp
kubectl apply -f svc.yml

# Apply Ingress
kubectl apply -f ingress.yml
