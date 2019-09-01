provider "aws" {
  region = "ap-northeast-2"
}

locals {
  tags = merge(var.tags, {
    Module = "ec2_monitor"
  })
}
