
# Terraform Snippets

## Providers

```terraform
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}
```

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
}
```

```terraform
terraform {
 required_providers {
   google = {
     source = "hashicorp/google"
     version = "5.3.0"
   }
 }
}

provider "google" {
 # Configuration options
}
```

```terraform
terraform {
 required_providers {
   kubernetes = {
     source = "hashicorp/kubernetes"
     version = "2.23.0"
   }
 }
}

provider "kubernetes" {
 # Configuration options
}
```

```terraform
terraform {
 required_providers {
   alicloud = {
     source = "aliyun/alicloud"
     version = "1.211.2"
   }
 }
}

provider "alicloud" {
 # Configuration options
}
```

## How to Use TF Providers

variables.tf

```terraform
variable "location" {
    description =   "Location of the resource group"
    type        =   string
    default     =   "eastasia"
}
```

main.tf

```terraform
resource "azurerm_resource_group" "rg" {
  name     = "example-resources"
  location = var.location
}
```


