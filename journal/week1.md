# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Tags

[How to Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locally delete a tag
```sh
$ git tag -d <tag_name>
```

Remotely delete tag
```sh
git push --delete origin tagname
```

Checkout the commit that you want to retag. Grab the sha from your Github history.

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```
## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
|
|-- main.tf            # everything else
|-- variables.tf       # stores the structure of input variables
|-- terraform.tfvars   # the data of variables we want to load into our Terraform project
|-- providers.tf       # defines required providers and their configuration
|-- outputs.tf         # stores outputs
|__ README.md          # this is required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables
### Terraform Cloud Variables

In terraform we can set two kinds of variables:
- Environment Variables - those that you would set in your bash terminal eg. AWS credentials.
- Terraform Variables - those that you would normally set in your tfvars file.

We can set Terraform Cloud variables to be sensitive so they are not shown visibly in the UI.

### Loading Terraform Input Variables

Documentation relevant to the subjects below can be found at this link:
[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_uuid="my-user_id` at the command line.

### var-file flag
We can also make use of the variables.tf file to pass in variables.  We can use input files which is what would be documented in the variables.tf file.  We can also use this to output results.  Be aware that if you are sending sensitive information to use the appropriate flag to supress it from being seen.

### terraform.tfvars

This is the default file to load in terraform variables in bulk.

### auto.tfvars

If there is a variable that we want to specifically set we can make use of the auto.tfvars to set these variables.  

### Order of terraform variables

Terraform follows a specific order in loading variables which is shown below.
If for any reason a file is missing it just goes to the next avaiable file in the list.
- Environment variables
- Terraform.tfvars file
- Terraform.tfvars.json
- Any *.auto.tfvars or *.auto.tfvars.json files processed in lexical order
- Any -var and -var-file options on the command line in the order they are provided, this includes Terraform Cloud workspace.


## Dealing With Configuration Drift

## What happens if we lose our state file?

If you lose your statefile, you most likely have to tear down all your cloud infrastructure manually.

You can use terraform import but it won't work for all cloud resources.  You need to check the terraform providers documentation for which resources support import.
### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

We discovered resources were missing as we didn't properly destroy our infra.  We made use of the import flag to import a bucket name and create it.
[Terraform Import](https://developer.hashicorp.com/terraform/language/import)
[Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorop/aws/latest/docs/resources/s3_bucket#import)
### Fix Manual Configuration

Through some manual configurations we were able to correct some mistakes that occurred to us not properly destroying our s3 bucket through ClickOps.  It will try and put our infra back in place with the expected state.
[Manage Resource Drift](https://developer.hashicorp.com/terraform/tutorials/state/resource-drift)

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure

It is recommended to place modules in a module directory when locally developing modules.  Feel free to name it whatever you would like. We named it with _aws as it was aws

### Passing Input Variables

We can pass input variables to our module.
The module has to declare these terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
    source = "./modules/terrahouse_aws"
    user_uuid = var.user_uuid
    bucket_name = var.bucket_name
}
```

### Module Sources

We can import the module from various places eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
    source = "./modules/terrahouse_aws"
}
```
[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform 

LLMs such as ChaptGPT may not be trained on the latest documenation or information about Terraform.

It may likely produce older examples that could be deprecated.  THis will affect providers.  Be sure to check latest documenation on the Terraform registry to validate.

## Working with Files in Terraform

### Fileexists function

This is a built in terraform m=fuction that allows you to check if a file exists.  If the fileexists no changes are made.

```
condition = fileexists(var.error_html_filepath)
```

[fileexists Function](https://developer.hashicorp.com/terraform/language/functions/fileexists)
### Filemd5 function

This function checks to see if the contents of the file have changed by using the md5 of the file.  If it is different it updates accordingly.

[filemd5 Function](https://developer.hashicorp.com/terraform/language/filemd5)
### Path Variable

In Terraform there is a special variable called `path` that allows for local path reference:
- path.module = get the path for the current module
- path.root = get the path for the root module of the project
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}

## Terraform Locals

Locals allow us to define local variables.
It can be very useful when we need to transform data into another format and have it referenced as a variable.
```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)
## Terraform Data Sources

This allows us to source data from cloud resources.
This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current: {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Terraform Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

We used the jsonencode to create the json policy inline in the hcl.


```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```
[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the Lifecycle of Resources

THis allows up to be able to see new updates and content when resources are updated
[Meta Arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

[Data Sources](https://developer.hashicorp.com/terraform/language/resources/terraform-data

## Provisioners

Provisioners allow you to execute commands on compute instances for example, AWS CLI command.  They are not recommended for use by Hashicrop because Configuation Management tools such as Ansible are a better fit but the functionaility exists.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)
### Local-exec

This will execute a command on the machine running the terraform commands, example terraform plan/apply.

```tf
resource "aws_instance" "web" {
  provisioner "local-exec" {
    command = "echo The server's IP
    address is ${self.private_ip}"
  }
}
```

### Remote-exec

This will execute commands on a target machine.  You will need to provide credentials such as ssh to get into the machine.  That 
may not be secure.
```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```