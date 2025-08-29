// modules/security_group/variables.tf
variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "sg_name" {
  description = "The name of the security group."
  type        = string
}

variable "sg_description" {
  description = "The description of the security group."
  type        = string
}

variable "ingress_rules" {
  description = "A list of ingress rules for the security group."
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = []
}