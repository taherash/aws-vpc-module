resource "aws_network_acl" "t_nacl" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.nacl_name
  }
}

resource "aws_network_acl_rule" "t_ingress" {
  for_each = local.nacl_vpc_public_subnet_ingress_rules
  
  network_acl_id = aws_network_acl.t_nacl.id
  egress         = false
  
  rule_number    = each.value.rule_number
  protocol       = each.value.protocol
  rule_action    = "allow"
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port
}

resource "aws_network_acl_rule" "t_egress" {
  for_each = local.nacl_vpc_public_subnet_egress_rules
  
  network_acl_id = aws_network_acl.t_nacl.id
  egress         = true
  
  rule_number    = each.value.rule_number
  protocol       = each.value.protocol
  rule_action    = "allow"
  cidr_block     = each.value.cidr_block
  from_port      = each.value.from_port
  to_port        = each.value.to_port 
}

resource "aws_network_acl_association" "t_nacl_association" {
  count          = length(var.subnet_ids)
  network_acl_id = aws_network_acl.t_nacl.id
  subnet_id      = var.subnet_ids[count.index]
}
