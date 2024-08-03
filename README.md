# s_one Devops Skills
Basic projects focused on devops skills.

## Pre-Requisites
- A PEM-RSA SSH KeyPair, you can create it using `ssh-keygen -t rsa -b 2048 -m PEM -f s-one_key.pem`
- Terraform
- Git
- AWS Admin Account (Access And Secret Keys)
    - A S3 Bucket to store .tfstate file

## Usage
- To Deploy the resources go to [aws_resources](./aws_resources/) folder and follow the readme instructions.

## Installation
- git clone https://github.com/agonzalezo/s_one.git
- Default env vars,
    ```bash
    NODE_ENV='production'
    ```