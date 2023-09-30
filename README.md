# Terraform Beginner Bootcamp 2023

- [Semantic Versioning](#semantic-versioning)
- [Install the Terraform CLI](#install-the-terraform-cli)
  * [Considersations with the Terraform CLI changes](#considersations-with-the-terraform-cli-changes)
  * [Considerations for Linux Distribution](#considerations-for-linux-distribution)
  * [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
  * [Shebang Considerations](#shebang-considerations)
    + [Execution Considersatons](#execution-considersatons)
    + [Linux Permissions Considerations](#linux-permissions-considerations)
  * [Github Lifecycle (Before, Init, Command)](#github-lifecycle--before--init--command-)
  * [Working with Env Vars](#working-with-env-vars)
    + [env command](#env-command)
    + [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
    + [Printing Vars](#printing-vars)
      - [Scoping of Env Vars](#scoping-of-env-vars)
    + [Persisting Env Cars in Gitpod](#persisting-env-cars-in-gitpod)
  * [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
  * [Terraform Registry](#terraform-registry)
  * [Terraform Console](#terraform-console)
    + [Terraform Init](#terraform-init)
    + [Terraform Plan](#terraform-plan)
    + [Terraform Apply](#terraform-apply)
    + [Terraform Destroy](#terraform-destroy)
    + [Terraform Lock Files](#terraform-lock-files)
    + [Terraform State Files](#terraform-state-files)
    + [Terraform Directory](#terraform-directory)
  * [Bucket Creation](#bucket-creation)
- [Issues with Terraform Cloud Login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)

## Semantic Versioning


This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes


## Install the Terraform CLI
### Considersations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes.  So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built against Ubuntu.
Please consider checking your LInux Distribution and change accordingly to your distirbution needs.

[How To Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:

```
$ cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg deprecation issues, we noticed the bash scripts steps were a considerable amount more code.  So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This will allow us an easier time to debug and execute manually Terraform install.
- This will allow better portability for other projects that need to install Terraform CLI.

### Shebang Considerations

A Shebang (pronounced Sha-bang) tells the bash script what program that will interpet the script. eg `#!/bin/bash`

ChatGPT recommended we use this format for bash: `#!/usr/bin/env bash`

- for portability for different OS distributions.
- Will search the user's PATH for the bash executable

https://en.wikipedia.org/wiki/Shebang_(Unix)
#### Execution Considersatons

When executing the bash script we can use the `./` shorthand notation to execute the bash script.

eg. `./bin.install_terraform_cli`

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it.

eg. `source ./bin/install_terraform_cli`
#### Linux Permissions Considerations

In order to make our bash scripts executable we need to change linux permission for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

We could also alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```
https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working with Env Vars

#### env command

We can list out all the Environment Variables (Env Vars) using the `env` command.

We can filter specific env vars using grep eg. `env |grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

In the terminal we unset using `unset HELLO`

We can set an env var temporarily when just running a command.

```sh
HELLO='world' ./bin/print_message
```
Within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Vars

We can print an env car using echo eg. `echo $HELLO`

##### Scoping of Env Vars

When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you want Env Cars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. `.bash_profile`

#### Persisting Env Cars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```gp env HELLO='world'
```

All future workspaces launched will set the env cars for all bash terminals opened in those workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars.

### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](.bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```

If it is successful you should see a json payload return that looks like this:

```json
{
    "UserId": "CZDJS7HCAH972FPMUEM8K",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credits from IAM User in order to use the user AWS CLI.
Used existing AWS credentials already established and added new user for terraform bootcamp only.

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registory which is located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow you to create resources in terraform.
- **Modules** are a way to make large amounts of terraform code modular, portable and shareable.

[Random Terraform Providers](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console

We can see a list of all the Terraform commands by simply typing `terraform`

#### Terraform Init

`terraform init`

At the start of a new terraform project, we will run `terraform init` to download the required binaries we will use for the project.

#### Terraform Plan

`terraform plan`

This will generate a changeset about the state of our infrastructure and what will be changed.  We can output this to a file to be passed to an apply, but often you can ignore outputting.

#### Terraform Apply

`terraform apply`

This will run the plan that was generated previously and pass the changeset to the executable by terraform.  Apply should prompt us to input yes or no.

If we want to automatically approve then pass the auto approve flag `terraform apply --auto-approve`

#### Terraform Destroy

`terraform destroy`

This will destroy resources.

If we want to skip having to type 'yes' we can add the --auto-approve flag.  We would use `terraform apply --auto-approve`.
#### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform Locak File **should be committed** to your Version Control System (VSC) eg. Github

#### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastructure.

This file **should not be committed** to your VCS.

This file can contain sensitive data.

If you lose this file, you lose the state information of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

#### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

### Bucket Creation

We updated our main.tf file to create an s3 bucket in AWs.  We first created a random bucket using terraform provider and executed the terrform terraform init/plan/apply to validate the bucket was created.

We made use of the 'random' provider and generated a bucket.  

We then tested within AWS and attempted to create a bucket.  The bucket was not created due to the below issues:
- The bucket name contained an upper case letter
This is a direct violation of AWS bucket naming conventions.  We addressed this by adding two variables
- upper = true
- lower = false

We were then able to execute the terraform plan and validate the bucket was there.

## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch via bash a wiswig view to generate a token.  But it does not work as expected in Gitpod VSCode browser.

We solved this by implementing a workaround which required us to manually create the file and copy/paste our token into the file and
generate the file in Terraform Cloud.

The token can be found here:

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then manually create the file below and open the file:

```sh
touch /home/gitpod/.terraform.d/credentials.json
```

Insert the code below and replace 'YOUR-TERRAFORM-CLOUD-TOKEN' with your actual token:

```json
{
    "credentials": {
        "app.terraform.io": {
            "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
        }
    }
}
```
We have automated this workaround with bash scripting, script can be found at [./bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)




