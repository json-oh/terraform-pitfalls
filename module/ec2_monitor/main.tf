provider "aws" {}

locals {
  tags = merge(var.tags, {
    Module = "ec2_monitor"
  })
}
