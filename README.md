# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

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

### Github Lifecycle (Before, Init, Command)

When working with the Gitpod lifecycle, it's essential to be cautious. Specifically, the 'Init' phase won't rerun if you restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/workspace/tasks

