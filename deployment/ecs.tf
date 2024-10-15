data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet*"]
  }
}

locals {
  prefix = "ce6-capstone-group3-${var.env}" #Change
}

module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.9.0"


  cluster_name = "${local.prefix}-ecs"


  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 10
      }
    }
  }

  services = {
    ce6-capstone-group3-dev = { #task def and service name -> #Change
      cpu    = var.ecs_cpu
      memory = var.ecs_mem
      #Container definition(s)
      container_definitions = {
        dev = { #container name
        
          name = "dev-8088-tcp"
          essential = true
          image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${local.prefix}-ecr:1"
          port_mappings = [
            {
              containerPort = 8088
              protocol      = "tcp"
            }
          ]
        }
      }
      assign_public_ip                   = true
      deployment_minimum_healthy_percent = 100
      subnet_ids                         = flatten(data.aws_subnets.public_subnets.ids)
      security_group_ids                 = [aws_security_group.ecs-sg.id]
    }
  }
}

# module "ecs_sg" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "~> 5.1.0"

#   name                = "${local.prefix}-ecs-sg"
#   description         = "Security group for ecs"
#   vpc_id              = data.aws_vpc.main.id
#   ingress_cidr_blocks = ["0.0.0.0/0"]
#   ingress_rules       = ["http-8088-tcp"]
#   egress_rules        = ["all-all"]
# }

resource "aws_security_group" "ecs-sg" {
  name        = "${local.prefix}-ecs-sg"
  description = "Security group for ecs"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = 8088
    to_port     = 8088
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
