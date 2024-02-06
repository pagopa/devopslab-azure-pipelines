# devopslab-azure-pipelines

A collection of common tools to automate our projects configurations.

Find more informaton how to use and contribute in each README.

## Index

1. [Azure DevOps Projects](https://github.com/pagopa/gitops/blob/main/azure-devops)

## Precommit checks

Check your code before commit.

<https://github.com/antonbabenko/pre-commit-terraform#how-to-install>

```sh
pre-commit run -a
```

## Terraform lock.hcl

We have both developers who work with your Terraform configuration on their Linux, macOS or Windows workstations and automated systems that apply the configuration while running on Linux.
<https://www.terraform.io/docs/cli/commands/providers/lock.html#specifying-target-platforms>

So we need to specify this in terraform lock providers:

```sh
terraform init

rm .terraform.lock.hcl

terraform providers lock \
  -platform=linux_arm64 \
  -platform=linux_amd64 \
  -platform=darwin_amd64 \
  -platform=windows_amd64
```
