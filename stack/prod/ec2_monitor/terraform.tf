terraform {
  required_version = ">= 0.12"
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-state"
    key            = "prod/ec2_monitor/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
    role_arn       = "arn:aws:iam::123456789012:role/TerraformAccess"
  }
}
