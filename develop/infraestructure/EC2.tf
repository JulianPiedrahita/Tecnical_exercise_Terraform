resource "aws_instance" "public_server" {
  count                  = var.public_server_count
  ami                    = data.aws_ami.ubuntu.id
  key_name               = aws_key_pair.server.key_name
  instance_type          = var.server_type
  subnet_id              = module.network.public_subnets[count.index]
  vpc_security_group_ids = [aws_security_group.server.id]

  associate_public_ip_address = var.include_ipv4
  tags = {
    Name = "PublicServer-${count.index}"
  }
}

resource "aws_key_pair" "server" {
  key_name   = "youtube"
  public_key = tls_private_key.server.public_key_openssh
}

resource "tls_private_key" "server" {
  algorithm = "RSA"
  rsa_bits  = 4096
}