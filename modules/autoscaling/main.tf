// to ssh into the instance use ssh -i ~/.ssh/terraform-key-pair ec2-user@IP Address
// scp -i ~/.ssh/terraform-key-pair ~/.ssh/terraform-key-pair ec2-user@IP Address:~/.ssh/

resource "aws_launch_configuration" "ecs_launch_config" {
  image_id                    = var.image_id
  instance_type               = var.instance_type
  security_groups             = [var.ecs_security_group]
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = true
  key_name                    = aws_key_pair.terraform-key-pair.id
  user_data                   = file("~/Desktop/ecs_terraform_project/modules/iam/install_ssm_agent.sh")
}

resource "aws_autoscaling_group" "ecs_autoscaling_group" {
  vpc_zone_identifier       = [var.private_subnet_id_a, var.private_subnet_id_b]
  launch_configuration      = aws_launch_configuration.ecs_launch_config.name
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 60
  health_check_type         = "EC2"

  tag {
    key                 = "Name"
    value               = "${var.vpc_name}-${var.env}-ecs_instances"
    propagate_at_launch = true
  }
}

resource "aws_instance" "bastion_host_instance" {
  instance_type     = var.instance_type
  ami               = var.image_id
  availability_zone = var.availability_zones[0]
  subnet_id         = var.public_subnet_id
  key_name          = aws_key_pair.terraform-key-pair.id
  security_groups   = [var.bastion_host_sg]

  tags = {
    Name = "${var.vpc_name}-${var.env}-bastion_host"

  }
}

resource "aws_key_pair" "terraform-key-pair" {
  key_name   = var.key_name
  public_key = file("~/.ssh/terraform-key-pair.pub")
}
