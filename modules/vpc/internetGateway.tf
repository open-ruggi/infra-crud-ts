resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  depends_on = [
    aws_vpc.main
  ]
  tags = {
    Name = "${var.environment_name}_internet_gateway"
  }
}
