terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.25.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.3" # Replace with the desired version or version constraint
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

