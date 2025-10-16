# sre-takehome-imanage
Take Home Project for iManage SRE Intern - Nicholas Pinzin

# Files
project.tf
- Details the code to set up a basic EC2 instance running Amazon Linux 2 with a simple nginx server running taking incoming traffic on port 80.

# Usage
- Ensure you have terraform CLI installed:
choco install terraform

- Run terraform init to initialize the directory
cd ./sre-takehome-imanage
terraform init

- Run terraform plan to see the expected created objects when running the file
terraform plan

- Run terraform apply to appl changes and launch ec2 instance
terraform apply
