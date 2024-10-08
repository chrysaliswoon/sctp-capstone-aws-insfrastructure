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
        weight = 100
      }
    }
  }
  services = {
    ce6-capstone-group3-service = { #task def and service name -> #Change d
      cpu    = 512
      memory = 1024
      # Container definition(s)
      container_definitions = {
        grp3-ecs = { #container name
          essential = true
          image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${local.prefix}-ecr:latest"
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
      subnet_ids                         = aws_subnet.public_subnets[*].id
      security_group_ids                 = [module.ecs_sg.security_group_id]
    }
  }
}

module "ecs_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1.0"

  name                = "${local.prefix}-ecs-sg"
  description         = "Security group for ecs"
  vpc_id              = data.aws_vpc.default.id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-8080-tcp"]
  egress_rules        = ["all-all"]
}