# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
├── main.tf - everything else               
├── variables.tf - stores the structure of input variables           
├── terraform.tfvars - the data of variables we want to load into our terraform project        
├── providers.tf - defined required providers and their configuration            
├── outputs.tf  - stores our outputs            
└── README.md - required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In Terraform, there are two types of variables:
- **Environment Variables:** Typically set in your bash terminal (e.g., AWS credentials).
- **Terraform Variables:** Usually set in your `.tfvars` file.

You can set variables in Terraform Cloud to be sensitive, meaning they will not be visible in the UI.

### Loading Terraform Input Variables

Explore more about [Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables).

### Var Flag

Utilize the `-var` flag to assign an input variable or to override a variable in the `.tfvars` file.

Example:
```sh
terraform -var user_uuid="my user_id"
```

### Var-file Flag

The `-var-file` flag allows you to specify a file containing variable values when executing Terraform commands.

**Example Usage:**
```sh
terraform apply -var-file="variables.tfvars"
```
If variables.tfvars contains:

```sh
region = "us-west-1"
```
Terraform will utilize the specified region value during execution.

### Terraform.tvfars

Instead of running the var flag, you can add variable to terraform.tfvars to make the variable specified and you should only have to run `terraform plan` without having to specify the `-var` flag.

### Order of Terraform Variables

Terraform variables can be defined in several places, with some taking precedence over others when there are conflicts:

#### Command-Line Flags
Values specified with -var and -var-file on the command line have the highest precedence.

```sh
terraform apply -var="region=us-east-1"
```


#### Environment Variables
If not specified via command-line flags, Terraform checks for environment variables prefixed with TF_VAR_.


```sh
export TF_VAR_region="us-east-2"
```

#### Variable Definitions File
Terraform checks for variable definitions in files named terraform.tfvars or terraform.tfvars.json.


```sh
region = "us-west-1"
```

#### Variable Defaults
Finally, if no other values are provided, Terraform uses the default defined in the configuration.

```sh
variable "region" {
  default = "us-west-2"
}
```

## Dealing with Configuration Drift

When your infrastructure's actual state diverges from the Terraform configuration, you're dealing with configuration drift.

## What happens if we lose our state file?

If you lose your **Statefile**, you most likely have to tear down all your cloud infrastructure manually. 

You can use terraform import but it won't work for all cloud resources. You need to check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

Manual Destruction: You might have to manually delete all associated cloud infrastructure for consistency. 

Use of terraform import:

Importing can help re-establish some lost links, but it doesn't work universally.
Example for AWS S3 bucket:

`terraform import aws_s3_bucket.website_bucket`

[Terraform Import](https://developer.hashicorp.com/terraform/language/import)

[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

For resources changed or deleted manually "ClickOps':

Running `terraform plan` aims to revert infrastructure to the expected state, correcting configuration drift.
