
#################################
# ELK Setup on Kubernetes Cluster
#################################

# Git Clone Url
git clone https://github.com/hussainaphroj/ELK-kubernetes.git

# Set Current Context
kubectl config set-context --current --namespace=kube-system

# Setup Ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

# Setup Cluster Role Binding for ELK
# Create the service account which has read access to service, endpoint and namespaces
kubectl apply -f rbac.yml

# Setup Elastic Search
# Elastic Search is the CLI service used to manage logs
kubectl apply -f elastic.yml
kubectl apply -f elastic-service.yml

# What is Log Stash Used for?
# Logstash receives the logs and formate them in a way that Elasticsearch understand
kubectl apply -f logstash-config.yml 
kubectl apply -f logstash-deployment.yml

# Once logstash is deployed successfully, we deploy the filebeat agent to ship the logs to Logstash. We will use the Daemonset kind of deployment which ensure that a pod will running on each node
kubectl apply -f filebeat-daemon-set.yml

# Deploy the Kibana now for log visualisation
# This is the UI, similar to Grafana
kubectl apply -f kibana.yml

# Deploy Sample Deployment for Testing Kibana, Elastic Search
kubectl apply -f web-deployment.yml
