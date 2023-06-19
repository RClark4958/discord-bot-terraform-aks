## Simple Terraform Azure Deployment

#### This terraform creates an aks cluster, installs wordpress with helm, and configures a custom docker deployment

#### Run the sa-account folder first to create storage for the tfstate file. Key vault creation requires an existing azure service principal.

##### Secrets can be kept in a dev.tfvars file and should be kept out of version control