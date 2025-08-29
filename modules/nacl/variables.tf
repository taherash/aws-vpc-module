variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "nacl_name" {
  description = "The name for the NACL."
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to associate with the NACL."
  type        = list(string)
}

variable "inbound_rules" {
  description = "A list of inbound NACL rules."
  type = list(object({
    rule_number = number
    protocol    = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

variable "outbound_rules" {
  description = "A list of outbound NACL rules."
  type = list(object({
    rule_number = number
    protocol    = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}
