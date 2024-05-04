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

  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true

  flow_log_max_aggregation_interval         = 60
  flow_log_cloudwatch_log_group_name_prefix = "/aws/my-amazing-vpc-flow-logz/"
  flow_log_cloudwatch_log_group_name_suffix = "my-test"
  flow_log_cloudwatch_log_group_class       = "INFREQUENT_ACCESS"

  tags = {
    Terraform   = "true"
    Environment = "Dev"
  }
}
