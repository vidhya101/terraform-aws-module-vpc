output "vpc" {
    value = module.vpc.vpc_id
}

output "public_subnets" {
    value = module.vpc.public_subnet_ids
}

output "private_subnets" {
    value = module.vpc.private_subnet_ids
}

output "public_subnets_cidr" {
    value = module.vpc.public_subnet_cidr_blocks
}

output "private_subnets_cidr" {
    value = module.vpc.private_subnet_cidr_blocks
}

output "internet_gateway" {
    value = module.vpc.internet_gateway_id
}

output "public_route_table" {
    value = module.vpc.public_route_table_id
}
