# s_one Devops Skills
Basic projects focused on devops skills.

This terraform files create all network infrastructure components and deploy some linux  and one windows servers, the security group create a rules to allow your public ip address to access to windows / linux common ports.

## Instructions
- Edit **./global_vars.tf** file, edit the ssh_public_key_path for your public key generated in the pre-requisites.
- Open this folder path in your preferred terminal.
- Create a S3 Bucket to store the **.tfstate** file, you can create it using aws web console or the cli:
    ```bash
    aws s3api create-bucket --bucket s-one-terraform-prod --region us-east-1
    ```
- Edit **./main.tf** file (around the third line) and edit the bucket name (created in the previous step).
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

## Connecting to remote servers.
### Windows Hosts

We need to obtain the **Administrador** password and the **IP Address**  to connect to the server.
- Get the IP, execute `terraform output dev_ec2` and copy **windows_ip** value.
- Get the instance ID, execute `terraform output dev_ec2` and copy **windows_instance_id** value.
- Decrypt the password using aws cli:
    - Locate your private key (from keypair genetared in the pre-requisites)
    - Run the below command replacing the **$INSTANCE_ID** with the id obtained from the previous step and copy the **PasswordData** value.
        ```bash
        aws ec2 get-password-data --instance-id $INSTANCE_ID --priv-launch-key s-one_key.pem
        ```
- Connect to the server using any RDP client:
    - USER: **Administrador**
    - IP/DNS: **IP Address obtained**
    - PASSWORD: **PASSWORD obtained**

### Linux Hosts
We just need the IP Address and the private key location.
- Locate your private key (from keypair genetared in the pre-requisites).
- Get the IP, execute `terraform output dev_ec2` and copy **Linux_ip** value.
- Connect to the server using OpenSSH client, Run below command replacing **$LINUX_IP with the IP Address obtained in the previous step.**: 
    ```bash
    ssh -i s-one_key ubuntu@$LINUX_IP
    ```
