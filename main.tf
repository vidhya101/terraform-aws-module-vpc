# Creating VPC 
resource "aws_vpc" "main" {
    cidr_block = var.vpc_config.cidr_block
    tags = {
        Name = var.vpc_config.name
    }
}

#Creating Subnet 
resource "aws_subnet" "main"{
    vpc_id = aws_vpc.main.id
    for_each = var.subnet_config

    cidr_block = each.value.cidr_block
    availability_zone = each.value.az
    
    tags ={
        Name = each.key
    }
}

locals {
    public_subnet = {
        for key, config in var.subnet_config: key => config if config.public
    }
    private_subnet = {
        for key, config in var.subnet_config: key => config if !config.public
    }
}

#Creating Internet Gateway, if there is atleast 1 public subnet 
resource "aws_internet_gateway" "main"{
    vpc_id = aws_vpc.main.id
    count = length(local.public_subnet) > 0 ? 1 : 0  #turnary operator 
}

#Routing Table for Public Subnet
resource "aws_route_table" "main"{
    vpc_id = aws_vpc.main.id
    count = length(local.public_subnet) > 0 ? 1 : 0
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main[0].id
    }

    tags = {
        Name = "${var.vpc_config.name}-public-rt"
    }
  
}


#Associating Public Subnet with Route Table
resource "aws_route_table_association" "main"{
    for_each = local.public_subnet
    subnet_id = aws_subnet.main[each.key].id
    route_table_id = aws_route_table.main[0].id
}