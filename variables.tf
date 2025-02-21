variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}