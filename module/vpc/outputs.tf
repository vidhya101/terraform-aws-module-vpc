#VPC Outputs

output "vpc_id" {
    description = "The ID of the VPC"
    value = aws_vpc.main.id
}

output "public_subnet_ids" {
    description = "List of Public Subnet IDs"
    az = [for key, config in local.public_subnet : aws_subnet.main[key].availability_zone]
    value = [for key, config in local.public_subnet : aws_subnet.main[key].id]
}

output "private_subnet_ids" {
    description = "List of Private Subnet IDs"
    az = [for key, config in local.private_subnet : aws_subnet.main[key].availability_zone]
    value = [for key, config in var.subnet_config : aws_subnet.main[key].id if !config.public]
}

output "public_subnet_cidr_blocks" {
    description = "List of Public Subnet CIDR Blocks"
    value = [for key, config in local.public_subnet : aws_subnet.main[key].cidr_block]
}

output "private_subnet_cidr_blocks" {
    description = "List of Private Subnet CIDR Blocks"
    value = [for key, config in var.subnet_config : aws_subnet.main[key].cidr_block if !config.public]
}

output "internet_gateway_id" {
    description = "The ID of the Internet Gateway"
    value = length(local.public_subnet) > 0 ? aws_internet_gateway.main[0].id : null
}

output "public_route_table_id" {
    description = "The ID of the Public Route Table"
    value = length(local.public_subnet) > 0 ? aws_route_table.main[0].id : null
}

