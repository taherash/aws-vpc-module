
/*
aws_vpc
aws_vpc_ipv4_cidr_block_association
aws_vpc_dhcp_options
aws_vpc_dhcp_options_association
aws_default_route_table
aws_route_table (private)
aws_route_table (public)
aws_default_network_acl
module private_network_acl
module public_network_acl
module internet_gateway
module egress_only_internet_gateway
module private_subnet
module public_subnet
module nat_gateway
*/


resource "aws_vpc" "t_vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-${var.environment}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.t_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.aws_availability_zone
  map_public_ip_on_launch = true
  #availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  tags = {
    Name        = "${var.project_name}-${var.environment}-public-subnet-${count.index}"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.t_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.aws_availability_zone
  #availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  tags = {
    Name        = "${var.project_name}-${var.environment}-private-subnet-${count.index}"
    Environment = var.environment
  }
}

# Add resources for NAT Gateway, private route tables, VPC endpoints, etc. as needed.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.t_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-public-rt"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.t_vpc.id

  tags = {
    Name        = "${var.project_name}-${var.environment}-igw"
    Environment = var.environment
  }
}

module "nacl" {
  source         = "./modules/nacl"
  vpc_id         = aws_vpc.t_vpc.id
  nacl_name      = "${var.project_name}-${var.environment}-nacl"
  subnet_ids     = [for s in aws_subnet.public : s.id]
  inbound_rules  = var.nacl_inbound_rules
  outbound_rules = var.nacl_outbound_rules
}

/*module "sg_web" {
  source         = "./modules/security_group"
  sg_name        = "${var.project_name}-${var.environment}-web-sg "
  vpc_id         = aws_vpc.t_vpc.id
  sg_description = "Security group for web access"
  ingress_rules  = var.web_sg_ingress_rules
}*/