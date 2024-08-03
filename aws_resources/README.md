# s_one Devops Skills
Basic projects focused on devops skills.

This terraform files create all network infrastructure components and deploy some linux servers and one windows server, the security group create a rules to allow your public ip address to access to windows / linux common ports.
In the output of `terraform output dev_ec2` you can see the linux_dns and windows_dns use they to connect.

## Instructions
- Edit **global_vars.tf** file, edit the ssh_public_key_path for your public key generated in the pre-requisites.
- open this folder path in your preferred terminal.
- Create a S3 Bucket to store the **.tfstate** file, you can create it using aws web console or the cli:
    ```bash
    aws s3api create-bucket --bucket s-one-terraform-prod --region us-east-1
    ```
- Edit main.tf file (around the third line) and edit the bucket name (created in the previous step).
- Init terraform modules using: 
    ```bash
        terraform init
    ```
- Plan the infrastructure using: 
    ```bash
        terraform plan
    ```
- Deploy the infrastructure using: 
    ```bash
        terraform apply
    ```
- 