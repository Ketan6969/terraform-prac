output "s3_bucket_name" {
  value       = aws_s3_bucket.terraform-state.id
  description = "Name of the Bucker"
}

output "s3_bucket_region" {
  value       = aws_s3_bucket.terraform-state.region
  description = "Region of the s3 bucket"
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform-state.arn
  description = "arn of s3 bucket"
}


output "dynamodb_table_name" {
  value       = aws_dynamodb_table.state-lock.id
  description = "name of the dynamo db table"
}

output "dynamodb_table_arn" {
  value       = aws_dynamodb_table.state-lock.arn
  description = "arn of the dynamodb table"
}