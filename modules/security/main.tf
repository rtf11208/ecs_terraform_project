resource "aws_security_group" "ronnie_ecs_sg" {
  vpc_id      = var.vpc_id
  description = "allow ssh traffic from public subnet to the private subnet"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
     from_port    = 80
     to_port      = 80
     protocol     = "tcp"
     cidr_blocks  = ["0.0.0.0/0"]
   }

    ingress {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks  = ["0.0.0.0/0"]
    }

    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  tags = {
    Name = "ecs_security_group"
  }
}

resource "aws_security_group" "bastion_host_sg" {
  vpc_id      = var.vpc_id
  description = "bastion host"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bastion_host_sg"
  }
}