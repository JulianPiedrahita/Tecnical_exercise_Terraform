resource "aws_flow_log" "this" {
  count = local.enable_flow_log ? 1 : 0

  log_destination_type       = var.flow_log_destination_type
  log_destination            = local.flow_log_destination_arn
  log_format                 = var.flow_log_log_format
  iam_role_arn               = local.flow_log_iam_role_arn
  deliver_cross_account_role = var.flow_log_deliver_cross_account_role
  traffic_type               = var.flow_log_traffic_type
  vpc_id                     = local.vpc_id
  max_aggregation_interval   = var.flow_log_max_aggregation_interval

  dynamic "destination_options" {
    for_each = var.flow_log_destination_type == "s3" ? [true] : []

    content {
      file_format                = var.flow_log_file_format
      hive_compatible_partitions = var.flow_log_hive_compatible_partitions
      per_hour_partition         = var.flow_log_per_hour_partition
    }
  }

  tags = merge(var.tags, var.vpc_flow_log_tags)
}