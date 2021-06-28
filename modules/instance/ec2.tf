// Create aws_ami filter to pick up the ami available in your region
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20210430"]
  }
}


data "template_file" "userdata_backend" {
  template = file("${path.module}/userdata_backend.yaml")
  vars = {
    ip_address_db = aws_instance.ec2_private_db.private_ip
  }
}

data "template_file" "userdata_db" {
  template = file("${path.module}/userdata_db.yaml")
}


// Configure the EC2 instance in a public subnet
resource "aws_instance" "ec2_public" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = var.public_subnets
  vpc_security_group_ids      = [aws_security_group.allow_ssh_pub.id,aws_security_group.allow_back_pub.id]
  user_data                   = data.template_file.userdata_backend.rendered

  depends_on = [
    aws_instance.ec2_private_db
  ]
  tags = {
    "Name" = "${var.environment}-ec2-public"
  }

  # Copies the ssh key file to home dir
  provisioner "file" {
    source      = "./${var.key_name}.pem"
    destination = "/home/ubuntu/${var.key_name}.pem"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.key_name}.pem")
      host        = self.public_ip
    }
  }
  
  //chmod key 400 on EC2 instance
  provisioner "remote-exec" {
    inline = ["chmod 400 ~/${var.key_name}.pem"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.key_name}.pem")
      host        = self.public_ip
    }

  }

}

resource "aws_instance" "ec2_private_db" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = false
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = var.private_subnets
  vpc_security_group_ids      = [aws_security_group.allow_ssh_priv.id,aws_security_group.allow_postgres_priv.id]

  user_data                   = data.template_file.userdata_db.rendered

  tags = {
    "Name" = "${var.environment}-ec2-private-db"
  }

}

// Configure the EC2 instance in a private subnet

# resource "aws_instance" "ec2_private_backend" {
#   ami                         = data.aws_ami.ubuntu.id
#   associate_public_ip_address = false
#   instance_type               = "t2.micro"
#   key_name                    = var.key_name
#   subnet_id                   = var.private_subnets
#   vpc_security_group_ids      = [aws_security_group.allow_ssh_priv.id]
#   user_data                   = data.template_file.userdata_backend.rendered

#   depends_on = [
#     aws_instance.ec2_private_db
#   ]
#   tags = {
#     "Name" = "${var.environment}-ec2-private-backend"
#   }

# }