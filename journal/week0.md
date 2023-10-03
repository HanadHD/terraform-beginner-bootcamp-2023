# Terraform Beginner Bootcamp 2023 - Week 0

- [Semantic Versioning](#semantic-versioning)
- [Install the Terraform CLI](#install-the-terraform-cli)
  * [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
  * [Considerations for Linux Distribution](#considerations-for-linux-distribution)
  * [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
    + [Shebang](#shebang)
- [Execution Considerations](#execution-considerations)
    + [Linux Permissions Considerations](#linux-permissions-considerations)
- [Gitpod Lifecycle](#gitpod-lifecycle)
- [Working Env Vars](#working-env-vars)
  * [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
  * [Printing Vars](#printing-vars)
  * [Scoping of Env Vars](#scoping-of-env-vars)
  * [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
- [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
  * [Terraform Registry](#terraform-registry)
  * [Terraform Console](#terraform-console)
    + [Terraform Init](#terraform-init)
    + [Terraform Plan](#terraform-plan)
    + [Terraform Apply](#terraform-apply)
    + [Terraform Destroy](#terraform-destroy)
  * [Terraform Lock Files](#terraform-lock-files)
  * [Terraform State Files](#terraform-state-files)
  * [Terraform Directory](#terraform-directory)
- [Issues with Terraform Cloud Login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)
- [Workaround](#workaround)

## Semantic Versioning

This project is going to utilize semantic versioning for its tagging.   [Semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes

The Terraform CLI installation instructions have been updated due to changes in the GPG keyring. We needed to refer to the most recent installation instructions via the Terraform Documentation and adjust the installation scripting accordingly.

### Considerations for Linux Distribution

This project is developed with Ubuntu in mind. Please ensure your Linux distribution aligns with the project's requirements and make necessary adjustments if needed.

### Refactoring into Bash Scripts

While fixing the Terraform CLI GPG depreciation, we notice that the bash scripting steps involved a significant amount of code. So we chose to refactor the process into a bash script to simplify the Terraform CLI installation.

The bash script can be found here: [Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

- Keeps the Gitpod Task File ([.gitpod.yaml](.gitpod.yaml)) tidy.
- Enables easier debugging and manual execution of the Terraform CLI installation.
- Increases portability for other projects that require Terraform CLI installation.

To verify your OS version in Linux, check out [How To Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/).

Example of checking the OS Version:

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

#### Shebang

A Shebang (pronounced Sha-bang) instructs the script on which interpreter to use for executing the script, e.g., `#!/bin/bash`.

ChatGPT recommends the format: `#!/usr/bin/env bash` for the following reasons:

- Enhanced portability across different OS distributions.
- It searches the user's `PATH` for the `bash` executable.

[Read more about Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

## Execution Considerations

When executing the bash scripts, you can use the `./` shorthand notation. For instance:

eg. `./bin/install_terraform_cli.sh`

When invoking a script in `.gitpod.yml`, you need to direct it to a progarm to interpret it:

eg. ` source ./bin/install_terraform_cli.sh`


#### Linux Permissions Considerations 

To make our bash script executable, we need to modify the Linux permissions for the file. You can make the script executable in user mode as follows:

```sh
chmod u+x ./bin/install_terraform_cli.sh
```

Alternatively:

```sh
chmod 744 ./bin/install_terraform_cli.sh
```

https://en.wikipedia.org/wiki/Chmod

## Gitpod Lifecycle

When working with the Gitpod lifecycle, it's essential to be cautious. Specifically, the 'Init' phase won't rerun if you restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/workspace/tasks

## Working Env Vars

We can list out all Environment Variables (Env Vars) using the `env` command

We can filter specfic env vars using grp eg. `env | grep AWS_`

### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='World`

In the terminal we unset using `unset HELLO`

We can set an env var temporaily when just running a command

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

### Scoping of Env Vars

When you open new bash terminals in VSCode it will be aware of Env Vars that you have set in another window.

If you want env vars to persist across all future bash terminals that are open, you must set Env Vars in your. eg. `bash_profile`

### Persisting Env Vars in Gitpod

We can persist env vars in Gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO'world'
```
All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars.

## AWS CLI Installation

The AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

- [Getting Started with AWS CLI Installation](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

- [AWS CLI Environment Variables](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

You can verify if your AWS credentials are configured correctly by running the following AWS CLI command:

```sh
aws sts get-caller-identity
```

If it is successful, you should see a JSON payload returned that looks like this:

```json
{
    "UserId": "T3AT370XPLOGMG7KOR60434F",
    "Account": "123456789102",
    "Arn": "arn:aws:iam::123456789102:user/terraform-beginner-bootcamp-2023"
}
```

To use the AWS CLI, we need to generate credentials from the IAM User

## Terraform Basics

### Terraform Registry

Terraform uses providers and modules from the [Terraform Registry](https://registry.terraform.io).

- **Providers**: Interfaces to APIs, allowing the creation of resources in Terraform.
- **Modules**: Help in making Terraform code modular, portable, and shareable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/)

### Terraform Console

View all Terraform commands by typing `terraform`.

#### Terraform Init

Run `terraform init` at the beginning of a new project to download the necessary binaries for the Terraform providers.

#### Terraform Plan

Use `terraform plan` to see the changeset, showing the current state and proposed changes to your infrastructure. 

#### Terraform Apply

Use `terraform apply` to run the planned changes. It will ask for confirmation by default. 
Use `terraform apply --auto-approve` to skip confirmation.

#### Terraform Destroy

`terraform destroy`
This command will destroy all resources that Terraform has managed. 
To bypass the approval prompt, use the auto-approve flag: `terraform destroy --auto-approve`.

### Terraform Lock Files

`.terraform.lock.hcl` holds the specific versions of providers or modules for the project. 
**Commit this file to your Version Control System (VCS)**, e.g., GitHub.

### Terraform State Files

`terraform.tfstate` holds the current state of your infrastructure. 

- **Do not commit this file to your VCS.** 
- This file contains sensitive data. 
- Losing this file means losing the state information of your infrastructure. 

`terraform.tfstate.backup` is the backup of the previous state.

### Terraform Directory

`.terraform` directory holds the binaries of Terraform providers.

## Issues with Terraform Cloud Login and Gitpod Workspace

While attempting to run `terraform login`, the command should ideally open a view to generate a token. 
However, this functionality doesn’t work as expected in the Gitpod VSCode in the browser, although it works locally in Gitpod VSCode.

 ## Workaround 
  If you are using Gitpod VSCode in the browser, manually generate a token in Terraform Cloud.

Navigate to the following URL to generate a token:

```
https://app.terraform.io/app/settings/tokens
```


After generating the token, manually create the credentials file with the following commands:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Add the following JSON code to the file, replacing "YOUR-TERRAFORM-CLOUD-TOKEN" with your actual token:

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD TOKEN"
    },
  }
}
```
We have automated this workaround process using the following bash script ./bin/generate_tfrc_credentials
