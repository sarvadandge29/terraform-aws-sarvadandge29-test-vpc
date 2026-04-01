output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Map of public subnet keys to their IDs and availability zones"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Map of private subnet keys to their IDs and availability zones"
  value       = module.vpc.private_subnet_ids
}