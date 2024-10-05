
variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "ce6-group3-vpc"
}

variable "environment" {
  description = "Environment or group for naming"
  type        = string
  default     = "ce6-group3"
}

# List of availability zones for subnet placement
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.1.0.0/16"
}

# Number of public subnets
variable "public_subnet_count" {
  description = "The number of public subnets to create"
  type        = number
  default     = 3
}

# CIDR blocks for public subnets
variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = [
    "10.1.1.0/24",
    "10.1.2.0/24",
    "10.1.3.0/24"
  ]
}

# Number of private subnets
variable "private_subnet_count" {
  description = "The number of private subnets to create"
  type        = number
  default     = 3
}

# CIDR blocks for private subnets
variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = [
    "10.1.4.0/24",
    "10.1.5.0/24",
    "10.1.6.0/24"
  ]
}
