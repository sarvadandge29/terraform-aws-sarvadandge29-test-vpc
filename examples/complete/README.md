# Complete VPC Example

This example demonstrates a complete VPC setup with both public and private subnets using the VPC module.

## Usage

```bash
# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

## Configuration

This example creates:

- **VPC**: `10.0.0.0/16` CIDR block named `my-test-vpc`
- **Public Subnets**:
  - `public_subnet`: `10.0.0.0/24` in `ap-south-1a`
  - `public_subnet-2`: `10.0.2.0/24` in `ap-south-1a`
- **Private Subnet**:
  - `private_subnet`: `10.0.1.0/24` in `ap-south-1b`

## Resources Created

| Resource                  | Count |
|---------------------------|-------|
| aws_vpc                   | 1     |
| aws_subnet                | 3     |
| aws_internet_gateway      | 1     |
| aws_route_table           | 1     |
| aws_route_table_association | 2    |

## Outputs

| Name               | Description                                    |
|--------------------|------------------------------------------------|
| vpc_id             | The ID of the VPC                              |
| public_subnet_ids  | Map of public subnet IDs with availability zones |
| private_subnet_ids | Map of private subnet IDs with availability zones |

## Customization

To use different values, modify `main.tf`:

```hcl
module "vpc" {
  source = "../module/vpc"

  vpc_config = {
    cidr_block = "YOUR_CIDR_BLOCK"
    name       = "YOUR_VPC_NAME"
  }

  subnet_config = {
    # Add your subnet configurations here
  }
}
```

## Clean Up

```bash
terraform destroy
```