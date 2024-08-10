
# How to configure Ingress

## References

[Kubernetes Ingress](https://spacelift.io/blog/kubernetes-ingress)
[GitHub Link](https://github.com/nginxinc/kubernetes-ingress/issues/257)
[Github Link II](https://github.com/nginxinc/kubernetes-ingress/issues/323)

Setup Azure AKS\
You can do it using basic Click-Ops, or via Terraform

*Context: I have a pre-written terraform template, that I'm going to apply*

```
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

# Provides configuration details for the Azure Terraform provider
provider "azurerm" {
  features {

  }
}

# Provides the Resource Group to logically contain resources
resource "azurerm_resource_group" "rg" {
  name     = "why-is-this-so-hard"
  location = "eastasia"
  tags = {
    environment = "dev"
    source      = "Terraform"
    name        = "Justin"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-witsh"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-witsh"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-cluster-witsh"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-witsh"

  default_node_pool {
    name       = "linux"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.subnet.id
  }

  network_profile {
    network_plugin = "azure"
    service_cidr    = "10.2.0.0/16"  # Non-overlapping service CIDR
    dns_service_ip  = "10.2.0.10"
  }

  identity {
    type = "SystemAssigned"
  }
}
```

```shell
tf apply -auto-approve
```

Set it as your current context

```shell
kubectl config set-context --current
```

Build your own Docker Image, preferrably an nginx image. This is the tag that we will use for the demo

```
txe1/simple-react-app
```

Once you have setup your kubernetes, and your docker, you need to first install kubernetes ingerss controller to AKS

```shell
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml
```

To check your installation, run this command

```shell
kubectl get service ingress-nginx-controller --namespace=ingress-nginx
```

Now that you have successfully installed ingress nginx controller, set up your deployment with the above docker image

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name:  react-app
  namespace: ingress-nginx
  labels:
    app:  react-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: react-app
  template:
    metadata:
      labels:
        app:  react-app
    spec:
      containers:
      - name:  react-app
        image:  txe1/simple-react-app:v4
        ports:
        - containerPort:  80
          name:  react-app
      restartPolicy: Always
---
apiVersion: v1
kind: Service
metadata:
  name: react-app
  namespace: ingress-nginx 
spec:
  type: ClusterIP
  ports:
  - port: 80
  selector:
    app: react-app
```

Ensure that the services are running. Now, add it as a path using the following ingress controller

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-world-ingress
  namespace: ingress-nginx
  annotations:
    nginx.ingress.kubernetes.io/use-regex: "true"
    nginx.ingress.kubernetes.io/add-base-url: "true"
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: aks-helloworld-one
            port:
              number: 80
      - path: /react-app
        pathType: Prefix
        backend:
          service:
            name: react-app
            port:
              number: 80
```

Success! You can now visit the site via the External IP. In the following example it would be:\
<http://20.255.220.68>
