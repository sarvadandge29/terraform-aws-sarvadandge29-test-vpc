#Vpc
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

locals {
  public_subnet_output = {
    for subnet_key, subnet in local.public_subnet : subnet_key => {
      subnet_id = aws_subnet.main[subnet_key].id
      az        = aws_subnet.main[subnet_key].availability_zone
    }
  }

  private_subnet_output = {
    for subnet_key, subnet in local.private_subnet : subnet_key => {
      subnet_id = aws_subnet.main[subnet_key].id
      az        = aws_subnet.main[subnet_key].availability_zone
    }
  }
}
#subnet
output "public_subnet_ids" {
  description = "Map of public subnet keys to their IDs and availability zones"
  value       = local.public_subnet_output
}

output "private_subnet_ids" {
  description = "Map of private subnet keys to their IDs and availability zones"
  value       = local.private_subnet_output
}
