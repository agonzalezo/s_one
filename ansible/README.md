# s_one Devops Skills
Basic projects focused on devops skills.

These ansible playbooks deploy a basic apache server on linux host and a MSSQL server on windows host.

## Important
***In the [../aws_resources](./aws_resources/) folder you can create the servers using terraform, the linux servers has ansible pre installed and this repo downloaded at "/opt/software_one/s_one-main/ansible", you can use they to run the playbooks.***

## Pre-Requisites
1. Clone this repository (or just [download it](https://github.com/agonzalezo/s_one/archive/refs/heads/main.zip)):
   ```bash
   git clone https://github.com/agonzalezo/s_one.git
   cd s_one/ansible
   ```
1. Copy the key-pair generated in the pre-requisites to the ansible server and **set permissions '0400'**
    ```bash
     ## On your host
     scp s-one_key.pem ubuntu@$LINUX_IP:/opt/software_one/s_one-main/ansible/
     ## On the Ansible Server
      chmod 400 s-one_key.pem
    ```
1. Edit the **inventory.ini** file adding the private ip of the your linux and windows servers.
1. Edit the **inventory.ini** setting the key-pair path for linux servers.
1. Edit the **inventory.ini** setting the password for windows servers.

## Installation
- If you want to install ansible locally in your pc please refer to [Ansible Install](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu)
## Usage
- To Install Apache (HTTPD) on linux servers
    ```bash
     ansible-playbook -i inventory.ini linux-playbook.yml
    ```
- To Install MSSQL on windows server (**It could take around 20 Minutes.**) 
    ```bash
     ansible-playbook -i inventory.ini windows-playbook.yml
    ```
