//vpc block
resource "aws_vpc" "main" {
  cidr_block        = var.vpc_cidr
  instance_tenancy  = "default"
  tags = {
    Name = "${var.vpc_name}-${var.env}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block          = var.public_subnet_cidr
  vpc_id              = aws_vpc.main.id
  availability_zone   = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-${var.env}-public_subnet"
  }
}

resource "aws_subnet" "private_subnet_a" {
  cidr_block          = var.private_subnet_a_cidr
  vpc_id              = aws_vpc.main.id
  availability_zone   = var.availability_zones[0]
  tags = {
    Name = "${var.vpc_name}-${var.env}-private_subnet_a"
  }
}

resource "aws_subnet" "private_subnet_b" {
  cidr_block          = var.private_subnet_b_cidr
  vpc_id              = aws_vpc.main.id
  availability_zone   = var.availability_zones[1]
  tags = {
    Name = "${var.vpc_name}-${var.env}-private_subnet_b"
  }
}

resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-${var.env}-internet_gateway"
  }
}

resource "aws_eip" "eip_a" {
  vpc = true
  tags = {
    Name = "${var.vpc_name}-${var.env}-EIP"
  }
}

resource "aws_eip" "eip_b" {
  vpc = true
  tags = {
    Name = "${var.vpc_name}-${var.env}-EIP"
  }
}

resource "aws_nat_gateway" "nat_gateway_a" {
  allocation_id = aws_eip.eip_a.id
  subnet_id     = aws_subnet.private_subnet_a.id

  tags = {
    Name = "${var.vpc_name}-${var.env}-nat_gateway"
  }

  depends_on = [aws_internet_gateway.IG]
}

resource "aws_nat_gateway" "nat_gateway_b" {
  allocation_id = aws_eip.eip_b.id
  subnet_id     = aws_subnet.private_subnet_b.id

  tags = {
    Name = "${var.vpc_name}-${var.env}-nat_gateway"
  }

  depends_on = [aws_internet_gateway.IG]
}

resource "aws_route_table" "ecs_route_table" {
  vpc_id = aws_vpc.main.id

   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }
}

resource "aws_route_table_association" "ecs_route_table" {
  route_table_id = aws_route_table.ecs_route_table.id
  subnet_id = aws_subnet.public_subnet.id
}