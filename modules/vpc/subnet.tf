data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnet
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch=true

  tags = {
    Name = "${var.environment_name}-public-${data.aws_availability_zones.available.names[0]}"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch=false

  tags = {
    Name = "${var.environment_name}-private-${data.aws_availability_zones.available.names[0]}"
  }
}
