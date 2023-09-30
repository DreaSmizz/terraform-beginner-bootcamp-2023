# Terraform Beginner Bootcamp 2023 - Week 1

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







