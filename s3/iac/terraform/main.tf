# https://registry.terraform.io/providers/hashicorp/aws/latest
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.2"
    }
  }
}

provider "aws" {
  # Configuration options
}

# COMMANDS
# terraform init
# terraform plan
# terraform apply