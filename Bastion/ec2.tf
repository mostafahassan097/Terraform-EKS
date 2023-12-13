
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
    content  = tls_private_key.ssh_key.private_key_pem
    filename = "${var.private_key_path}/${var.private_key_name}"
    file_permission = "0600"
}

resource "aws_key_pair" "public_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "aws_iam_instance_profile" "this" {
    name = "instance_profile"
    role = aws_iam_role.role.id    
}

resource "aws_instance" "bastion" {
  ami                    = var.ami  
  instance_type          = var.instance_type            # Choose an appropriate instance type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
  user_data              = var.user_data
  iam_instance_profile   = aws_iam_instance_profile.this.id

  tags = {
    Name = "${var.env}-bastion-instance"
  }

  depends_on = [ aws_iam_instance_profile.this,aws_iam_role.role ]
}

resource "aws_security_group" "bastion_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  
  egress {
    from_port = 0
    to_port = 0 
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 
}