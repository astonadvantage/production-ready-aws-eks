#------------------------------------------------------------------------------
# written by: Lawrence McDaniel
#             https://lawrencemcdaniel.com/
#
# date:       July-2023
#
# usage:      Terraform configuration
#------------------------------------------------------------------------------

terraform {
  required_version = "~> 1.5"

  # Edit the 'bucket', 'region', and 'dynamodb_table' fields to match the state management resources
  # you created.
  backend "s3" {
    bucket         = "292628133012-terraform-tfstate-hedclstr"
    key            = "hedclstr/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-lock-hedclstr"
    profile        = "default"
    encrypt        = false
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.8"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
    # helm = {
    #   source  = "hashicorp/helm"
    #   version = "~> 2.12.1"
    # }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.22"
    }
  }
}
