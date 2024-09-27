locals {
  prefix = "ce6-capstone-group3-dev" #Change
}
data "aws_caller_identity" "current" {}


data "aws_region" "current" {}


data "aws_vpc" "default" {
  default = true
}


data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


resource "aws_ecr_repository" "ecr" {
  name         = "${local.prefix}-ecr"
  force_delete = true
}


module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.9.0"


  cluster_name = "${local.prefix}-ecs"


  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }


  services = {
    ce6-capstone-group3-svc = { #task def and service name -> #Change
      cpu    = 512
      memory = 1024
      # Container definition(s)
      container_definitions = {
        ecs-superset = { #container name
          essential = true
          image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/grp3-superset-${local.prefix}:latest"
          port_mappings = [
            {
              containerPort = 8080
              protocol      = "tcp"
            }
          ]
        }
      }
      assign_public_ip                   = true
      deployment_minimum_healthy_percent = 100
      subnet_ids                         = flatten(data.aws_subnets.public.ids)
      security_group_ids                 = [module.ecs_sg.security_group_id]
    }
  }
}


module "ecs_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1.0"


  name        = "${local.prefix}-superset-sg"
  description = "Security group for ecs"
  vpc_id      = data.aws_vpc.default.id


  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-8080-tcp"]
  egress_rules        = ["all-all"]
}
