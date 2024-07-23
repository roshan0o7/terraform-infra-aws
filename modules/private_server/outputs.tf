output "private_server_id" {
  value = aws_instance.private_server.id
}

output "private_sg_id" {
  value = aws_security_group.private_sg.id
}