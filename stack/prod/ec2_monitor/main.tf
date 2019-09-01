provider "aws" {
  region = "ap-northeast-2"
}

provider "aws" {
  alias  = "aws_tokyo"
  region = "ap-northeast-1"
}

module "ec2_monitor" {
  source = "../../../module/ec2_monitor"

  providers = {
    aws = aws.aws_tokyo
  }

  environment = "prod"
  tags = {
    Phase = "prod"
  }
}