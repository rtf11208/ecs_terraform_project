output "ecs_security_group" {
  value = aws_security_group.ronnie_ecs_sg.id
}

output "bastion_host_sg" {
  value = aws_security_group.bastion_host_sg.id
}