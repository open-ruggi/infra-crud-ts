resource "aws_security_group" "allow_ssh_pub" {
  name        = "${var.environment}-allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from the internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-allow_ssh_pub"
  }
}

resource "aws_security_group" "allow_ssh_priv" {
  name        = "${var.environment}-allow_ssh_priv"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH only from internal VPC clients"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-allow_ssh_priv"
  }
}


resource "aws_security_group" "allow_postgres_priv" {
  name        = "${var.environment}-allow_postgres_priv"
  description = "Allow postgres inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Postgres port only from internal VPC clients"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Name = "${var.environment}-allow_postgres_priv"
  }
}

resource "aws_security_group" "allow_back_pub" {
  name        = "${var.environment}-allow_back_pub"
  description = "Allow back inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "backend port from the internet"
    from_port   = 7000
    to_port     = 7000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-allow_back_pub"
  }
}

