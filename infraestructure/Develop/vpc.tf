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

  tags = {
    Terraform   = "true"
    Environment = "Dev"
  }
}

resource "awscc_ec2_flow_log" "flow_log_dev" {
  deliver_logs_permission_arn = awscc_iam_role.example.arn
  log_destination_type        = "cloud-watch-logs"
  log_destination             = awscc_logs_log_group.example.arn
  traffic_type                = "ALL"
  resource_id                 = var.vpc_id
  resource_type               = "VPC"
  tags = [{
    key   = "Managed By"
    value = "AWSCC"
  }]
}

resource "awscc_logs_log_group" "flow_log_dev" {
  log_group_name = "flow_log_dev"
}

