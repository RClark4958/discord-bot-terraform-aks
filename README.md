## Simple Terraform Azure Deployment  <br><br>

#### This terraform will create an aks cluster and deploys both a wordpress blog and a discord bot with cluster resources. The bot is a chatgpt assistant, which is itself in another repo of mine. <br><br>

#### It is necessary to run the sa-account folder first on its own in order to create the storage where the tfstate will live. A service principal must also be created for key vault permissions. <br><br>

#### Deploying the kubernetes resources will require a kubeconfig which is made in the same round as the cluster, so is not available at first. Running terraform apply twice (the second time after configuring the kubeconfig locally) works, though there's probably a better way. <br><br>

##### If you are newer to terraform it's important to note that you will need to create a secrets.tfvars file that contains values for an field that contains a remotely sensitive variable repaced with a variable in this code. A few terraform fields don't allow variables so they are left as empty strings.