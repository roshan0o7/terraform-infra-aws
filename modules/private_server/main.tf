resource "aws_security_group" "private_sg" {
  name_prefix = "private-sg-"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [var.bastion_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "private_server" {
  instance_type = "t2.micro"
  subnet_id     = element(var.private_subnet_ids, 0)
  security_groups = [aws_security_group.private_sg.name]
  key_name                    = "awsprofile-ci-key"
  ami                         = "ami-04a81a99f5ec58529"
  associate_public_ip_address = true
  availability_zone       = element(var.availability_zones, 0)
  root_block_device {
    volume_size = 25
  }

  tags = {
    Name = "Private_Server"
  }
}
