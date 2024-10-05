terraform {
  required_version = ">= 1.0" 
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.58.0"  # Specify your preferred version constraint
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}