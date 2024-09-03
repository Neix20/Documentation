
# Notes

## References

- [Terraform Guide](https://www.terraform-best-practices.com/key-concepts)

- <https://github.com/collabnix/terraform/tree/master>
- <https://github.com/casa-de-vops/terraform-code-standards/tree/main>
- <https://github.com/antonbabenko/terraform-best-practices-workshop>
- <https://github.com/antonbabenko/terraform-best-practices>
- <https://collabnix.github.io/terraform/>

## Verbose Steps

1. Declare Terraform Provider
   1. providers.tf
   2. Azure Provider
   3. AWS Provider
   4. Kubernetes Provider
2. What is the final resource you want to declare?
   1. main.tf
   2. "azurerm_linux_virtual_machine"
   3. "azurerm_kubernetes_cluster"
   4. "aws_instance"
3. Does this resource have a specific property you wish to see?
   1. outputs.tf
   2. "aws_public_ip"
4. (Optional) If this terraform were to be used repeatedly, what are the variables needed?
   1. variables.tf
5. (Optional) What kind of environment is needed?

## Mermaid Steps
