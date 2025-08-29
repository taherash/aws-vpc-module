locals {
  nacl_vpc_public_subnet_ingress_rules = {
    t_vpc_public_subnet_ingress_all = {
      rule_number = 500
      protocol    = "tcp"
      from_port   = 1024
      to_port     = 65535
      cidr_block  = "0.0.0.0/0"
    },
    t_ssh_rule = {
      rule_number = 510
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_block  = "0.0.0.0/0"
    },
    t_http_rule = {
      rule_number = 520
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_block  = "0.0.0.0/0"
    },
    t_https_rule = {
      rule_number = 530
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      cidr_block  = "0.0.0.0/0"
    },
    t_vpc_public_subnet_ingress_icmp = {
      rule_number = 540
      protocol    = "icmp"
      from_port   = 0
      to_port     = 0
      cidr_block  = "0.0.0.0/0"
    }
  }

  nacl_vpc_public_subnet_egress_rules = {
    t_all_egress_rule = {
      rule_number = 500
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      cidr_block  = "0.0.0.0/0"
    }
  }
}