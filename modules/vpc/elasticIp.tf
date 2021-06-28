resource "aws_eip" "eip" {
  vpc = true
  depends_on = [aws_internet_gateway.gw]
  tags = {
    Name = "${var.environment_name}-nat_gw-ip"
  }
}
