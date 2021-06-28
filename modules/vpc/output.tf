output "aws_subnet_public" {
  value = aws_subnet.public.id
}
output "aws_subnet_private" {
  value = aws_subnet.private.id
}
output "vpc_id" {
  value = aws_vpc.main.id
}