#Vpc
output "vpc_id" {
  value = aws_vpc.main.id
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
  value = local.public_subnet_output
}

output "private_subnet_ids" {
  value = local.private_subnet_output
}
