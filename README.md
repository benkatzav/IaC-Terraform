# IaC-Terraform
Using Terraform to build the infrastructure of the Weight Tracker application

#### Infrastructure Diagram: (Treat the VMs inside the web tier as Scale Set)
![TOPOLOGY](https://user-images.githubusercontent.com/88583978/173969411-c62c8e3d-83ec-40d5-afd7-db42da983d7a.png)

### Description:
1. The Terraform template created is used to deploy the required infrastructure as defined in the diagram
2. For the Scale Set I used pre-prepared virtual machine image which already contains everything needed to run the application
3. Used PostgreSQL managed databased (flexible) that is not accessible from the internet
4. Using Auto-Scaling which increases the number of VM instances in the scale set when the load is increased (application demand increased)
5. The script also creates storage account and a container in which the Terraform state will be stored so after everything is completed you can go to providers.tf and uncomment the backend block, use the command ```terraform init``` again and the tfstate file will be saved in the container.
6. Everything is automated, once you initiate the infrastructure all you need to do is to enter one of the Scale Set virtual machines and run the ```npm run initdb``` command which connecting to the DB and creates the tables needed.
