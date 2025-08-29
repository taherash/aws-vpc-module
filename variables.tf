variable "project_name" {
  description = "The name of the project."
  type        = string
  default     = "taher-project"
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "172.16.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for public subnets."
  type        = list(string)
  default     = ["172.16.10.0/24"]
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for private subnets."
  type        = list(string)
  default     = ["172.16.20.0/24"]
}

variable "aws_availability_zone" {
  description = "The AWS availability zone"
  type        = string
  default     = "us-east-1a" # Set your default region
}

variable "nacl_inbound_rules" {
  description = "A list of inbound NACL rules for the VPC."
  type        = any
  default     = []
}

variable "nacl_outbound_rules" {
  description = "A list of outbound NACL rules for the VPC."
  type        = any
  default     = []
}

variable "web_sg_ingress_rules" {
  description = "Ingress rules for the web security group."
  type        = any
  default     = []
}