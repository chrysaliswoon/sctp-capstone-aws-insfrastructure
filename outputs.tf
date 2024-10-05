# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.my_igw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gw.id
}