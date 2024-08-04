# s_one Devops Skills
Basic projects focused on devops skills.

## Pre-Requisites
- A PEM-RSA SSH KeyPair, you can create it using `ssh-keygen -t rsa -b 2048 -m PEM -f s-one_key.pem`
- Terraform
- Git
- AWS Admin Account (AWS_ACCESS_KEY_ID And AWS_SECRET_ACCESS_KEY)
    - AWS CLI: [Official docs to install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions)
    - Credential configurations, you can use aws cli to configure or set variables in the global environment
        - [aws configure](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html#getting-started-quickstart-new-command)
        - [environment variables](https://docs.aws.amazon.com/sdk-for-php/v3/developer-guide/guide_credentials_environment.html)

## Usage
- To Deploy the resources go to [aws_resources](./aws_resources/) folder and follow the readme instructions.

## Installation
- git clone https://github.com/agonzalezo/s_one.git
- Default env vars,
    ```bash
    NODE_ENV='production'
    ```