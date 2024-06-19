###################################################
#This script will create a remote backend
###################################################

#Specified the required version
terraform {
  required_version = ">= 0.12"
}

#specified the required provider
provider "aws" {}

#Fetched the details of the current user
data "aws_caller_identity" "current" {}

#assigned a variable
locals {
  account_id = data.aws_caller_identity.current.account_id
}

#created the s3 bucket
resource "aws_s3_bucket" "terraform-state" {
  bucket = "${local.account_id}-terraform-state"
}

#Enabled the versioning for the bucket
resource "aws_s3_bucket_versioning" "terraform-state-versioning" {
  bucket = "aws_s3_bucket.terraform-state"
  versioning_configuration {
    status = "Enabled"
  }
}

#Enabled the server side encryption for the bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = "aws_s3_bucket.terraform-state"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

########################################################################################
#CREATING THE DYNAMODB LOCK
########################################################################################

resource "aws_dynamodb_table" "state-lock" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}