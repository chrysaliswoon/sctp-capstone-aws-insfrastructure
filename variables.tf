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
  description = "execution time in seconds before lambda function timeout"
}


