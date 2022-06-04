output "iam_ecs_instance_profile" {
  value = aws_iam_instance_profile.ecs_agent.id
}

output "ec2_iam_role" {
  value = aws_iam_role.ec2_ssm_role.id
}

output "ec2_instance_profile" {
  value = aws_iam_instance_profile.ec2_instance_profile.id
}

