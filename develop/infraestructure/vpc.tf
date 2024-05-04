resource "aws_vpc" "Vpc_Dev" {
  count = local.create_vpc ? 1 : 0

  cidr_block                       = var.cidr_block
  ipv4_ipam_pool_id                = var.vpc_ipv4_ipam_pool_id
  ipv4_netmask_length              = var.vpc_ipv4_netmask_length
  assign_generated_ipv6_cidr_block = var.vpc_assign_generated_ipv6_cidr_block
  ipv6_cidr_block                  = var.vpc_ipv6_cidr_block
  ipv6_ipam_pool_id                = var.vpc_ipv6_ipam_pool_id
  ipv6_netmask_length              = var.vpc_ipv6_netmask_length

  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_dns_support   = var.vpc_enable_dns_support
  instance_tenancy     = var.vpc_instance_tenancy

  tags = merge(
    { "Name" = var.name },
    module.tags.tags_aws
  )
}

module "network" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"
  
  name = "web"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_flow_log    = true
  vpc_flow_log_tags = local.tags

  tags = {
    Terraform   = "true"
    Environment = "Dev"
  }
}
