# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Git Tags

When working with git tags, there are times we may need to delete or replace them, either locally or remotely. Here's how to do it:

### Locally Delete a Tag

```sh
git tag -d <tag_name>
```

### Remotely Delete Tag

```sh
git push --delete origin <tagname>
```
### Retag a Commit

You can get the commit's SHA from your GitHub history or by using git log.
To exit git log, type “q” or “z”.

```sh
git checkout <SHA>
git tag M.m.P
git push --tags
git checkout main

```

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

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules


### Terraform Module Structure

Modules allow you to package Terraform configurations for reuse.

When locally developing modules, it's a common practice to organize them inside a modules directory. However, you're free to choose any name you prefer.

### Passing Input Variables

You can provide values to a module using input variables. Ensure the module declares these variables in its variables.tf:

```go
modules "terrahouse_aws" {
    source = "./modules/terrahouse_aws"
    user_uuid = var.user_uuid
    bucket_name = var.bucket_name
}
```

### Module Sources

The source argument in a module block allows you to specify where the module should be sourced from. This can be:

- locally
- GitHub
- Terraform Registry

```go
modules "terrahouse_aws" {
    source = "./modules/terrahouse_aws"
}
```
(https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform

When using LLMs (Large Language Models) like ChatGPT for Terraform guidance, keep in mind the following:

ChatGPT might not have the latest updates or documentation related to Terraform.

The provided examples could be outdated or deprecated, especially regarding providers.

## Working with Files in Terraform

### Fileexists function

Terraform includes a built-in function called fileexists that verifies the existence of a file:
We used it in our variables.tf nested

```go
 validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The specified file path for error.html does not exist."
  }
```

[Fileexists](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5

The filemd5 function generates a hash for the specified file. It can be particularly useful for creating unique eTags whenever there's a change in the file content: `etag = filemd5(var.index_html_filepath)`

[Filemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variables

Terraform has built-in variables related to file paths, which can be especially handy when referencing local paths:

- path.module: returns the path of the current module.
- path.root: rceturns the path of the root module.

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

When referencing files, these variables can be particularly useful:

```sh 
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html
  etag = filemd5(var.index_html_filepath)
} 
```  
## Terraform Locals

Terraform locals provide a way to define local variables. 
They are useful for transforming and organizing data, giving you a more structured way to reference variables within your configuration.

```go
locals {
  s3_origin_id = "myS3Origin"
}
```

[Locals Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources

Terraform data sources allow us to fetch information about existing cloud resources, making it easy to reference them in our Terraform configuration without explicitly defining them.

```go
data "aws_caller_identity" "current" {}
```

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

Terraform provides functions like jsonencode which help in converting HCL structures into JSON format.

```go
jsonencode({"hello"="world"})

{"hello":"world"}
```

[Jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the Lifecycle of Resources

[Meta Agruements Lifecycle ](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

```go
  lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
  }
```
[Data](https://developer.hashicorp.com/terraform/language/resources/terraform-data)