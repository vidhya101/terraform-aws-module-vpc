# Terraform AWS VPC Module

This Terraform module creates a flexible and reusable Virtual Private Cloud (VPC) in AWS. It simplifies the process of setting up the foundational network infrastructure, including public and private subnets, route tables, and internet connectivity.

## Features

- Creates a VPC with a specified CIDR block.
- Creates any number of public and private subnets based on a variable configuration.
- Creates an Internet Gateway and a public route table for public subnets.
- Optionally creates a NAT Gateway (and its associated Elastic IP) in a public subnet to provide outbound internet access for private subnets.
- Creates a private route table and associates it with private subnets.

---

## Usage

Here is an example of how to use this module in your Terraform configuration:

```terraform
module "my_vpc" {
  source = "./module/vpc" # Or the path to your module

  vpc_config = {
    name       = "my-app-vpc"
    cidr_block = "10.0.0.0/16"
  }

  subnet_config = {
    "public-subnet-a" = {
      cidr_block = "10.0.1.0/24"
      az         = "us-east-1a"
      public     = true
    },
    "public-subnet-b" = {
      cidr_block = "10.0.2.0/24"
      az         = "us-east-1b"
      public     = true
    },
    "private-subnet-a" = {
      cidr_block = "10.0.101.0/24"
      az         = "us-east-1a"
      public     = false
    },
    "private-subnet-b" = {
      cidr_block = "10.0.102.0/24"
      az         = "us-east-1b"
      public     = false
    }
  }
}

# You can then use the outputs from the module
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.my_vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.my_vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.my_vpc.private_subnet_ids
}
```

---

## Inputs

| Name            | Description                                                                                                 | Type                                               | Default | Required |
| --------------- | ----------------------------------------------------------------------------------------------------------- | -------------------------------------------------- | ------- | :------: |
| `vpc_config`    | An object containing the configuration for the VPC, including its name and primary CIDR block.                | `object({ name = string, cidr_block = string })`   | `n/a`   |   yes    |
| `subnet_config` | A map of subnet configurations. Each key is the subnet name and the value contains its CIDR, AZ, and public status. | `map(object({ cidr_block = string, az = string, public = bool }))` | `n/a`   |   yes    |

---

## Outputs

| Name                         | Description                                        |
| ---------------------------- | -------------------------------------------------- |
| `vpc_id`                     | The ID of the VPC.                                 |
| `public_subnet_ids`          | List of IDs for the created public subnets.        |
| `private_subnet_ids`         | List of IDs for the created private subnets.       |
| `public_subnet_cidr_blocks`  | List of CIDR blocks for the public subnets.        |
| `private_subnet_cidr_blocks` | List of CIDR blocks for the private subnets.       |
| `internet_gateway_id`        | The ID of the Internet Gateway.                    |
| `public_route_table_id`      | The ID of the route table for public subnets.      |
| `private_route_table_id`     | The ID of the route table for private subnets.     |

---

## Author

This module was created by [Your Name/Organization].

## License

[Specify your license, e.g., MIT, Apache 2.0]
