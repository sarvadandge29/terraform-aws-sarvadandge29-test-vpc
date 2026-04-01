# VPC Module

A Terraform module for creating an AWS VPC with configurable public and private subnets.

## Features

- Creates a VPC with customizable CIDR block and name
- Supports multiple subnets with configurable availability zones
- Automatically creates Internet Gateway for public subnets
- Configures route tables and associations for public subnets

## Prerequisites

- Terraform >= 1.0
- AWS Provider configured
- AWS credentials with permissions to create VPC, Subnets, Internet Gateway, and Route Tables

## Usage

```hcl
module "vpc" {
  source = "./module/vpc"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "my-vpc"
  }

  subnet_config = {
    subnet-1 = {
      cidr_block = "10.0.1.0/24"
      az         = "us-east-1a"
      public     = true
    }
    subnet-2 = {
      cidr_block = "10.0.2.0/24"
      az         = "us-east-1b"
      public     = true
    }
    subnet-3 = {
      cidr_block = "10.0.3.0/24"
      az         = "us-east-1a"
      public     = false
    }
  }
}
```

## Variables

### `vpc_config` (Required)

Configuration for the VPC.

| Name        | Type   | Description                    |
|-------------|--------|--------------------------------|
| cidr_block  | string | CIDR block for the VPC         |
| name        | string | Name tag for the VPC           |

**Validation:** The `cidr_block` must be a valid CIDR format.

### `subnet_config` (Required)

Map of subnet configurations.

| Name        | Type   | Description                                    | Default |
|-------------|--------|------------------------------------------------|---------|
| cidr_block  | string | CIDR block for the subnet                      | -       |
| az          | string | Availability zone for the subnet              | -       |
| public      | bool   | Whether the subnet is public (creates IGW)     | false   |

**Validation:** All `cidr_block` values must be valid CIDR format.

## Outputs

| Name               | Description                                    |
|--------------------|------------------------------------------------|
| vpc_id             | The ID of the VPC                              |
| public_subnet_ids  | Map of public subnet IDs with availability zones |
| private_subnet_ids  | Map of private subnet IDs with availability zones |

### Output Structure

```hcl
# public_subnet_ids and private_subnet_ids structure:
{
  subnet-1 = {
    subnet_id = "subnet-abc123"
    az        = "us-east-1a"
  }
}
```

## Resources Created

| Resource                  | Count/Condition                        |
|---------------------------|----------------------------------------|
| aws_vpc                   | 1                                      |
| aws_subnet                | One per subnet_config entry            |
| aws_internet_gateway      | 1 (only if public subnets exist)       |
| aws_route_table           | 1 (only if public subnets exist)       |
| aws_route_table_association | One per public subnet                 |

## License

MIT License