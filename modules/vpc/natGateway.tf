resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public.id
  depends_on = [aws_internet_gateway.gw]
  tags = {
    Name = "${var.environment_name}-natgw"
  }
}