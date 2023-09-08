[![CI](https://github.com/bihealth/cada-prio-data/actions/workflows/main.yml/badge.svg)](https://github.com/bihealth/cada-prio-data/actions/workflows/main.yml)

# (Weekly) CADA Model Builds

## Following Rolling Releases

This repository contains the build to build [cada-prio](https://github.com/bihealth/cada-prio) data releases following [clinvar-data-jsonl](https://github.com/bihealth/clinvar-data-jsonl) which itself is based on ClinVar XML releases.

# Developer Documentation

The following is for developers of `cada-prio-data` itself.

## Managing Project with Terraform

```
# export GITHUB_OWNER=bihealth
# export GITHUB_TOKEN=ghp_TOKEN

# cd utils/terraform
# terraform init
# terraform import github_repository.cada-prio-data cada-prio-data
# terraform validate
# terraform fmt
# terraform plan
# terraform apply
```
