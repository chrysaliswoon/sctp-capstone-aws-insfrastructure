variable "env" {
  type        = string
  description = "set environment type"
}

variable "lambda_mem" {
  type        = number
  default     = 1024
  description = "lambda memory"
}

variable "lambda_timeout" {
  type        = number
  default     = 6
  description = "execution time in seconds before lambda function timeout v2"
}

variable "ecs_cpu" {
  type        = number
  default     = 512
  description = "ecs computation power"
}

variable "ecs_mem" {
  type        = number
  default     = 512
  description = "ecs memory power"
}

variable "vpc_id" {
  type        = string
  default     = "vpc-0275669f3f5cfc856"
  description = "VPC ID"
}