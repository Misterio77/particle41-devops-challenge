terraform {
  backend "s3" {
    key    = "terraform.tfstate"
    # This has to be hardcoded. It does not have to match the provider, as we
    # create/import it through state_init.sh.
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49.0"
    }
  }
}

provider "aws" {
  # By default, terraform will use your AWS profile (either CLI config or
  # AWS_REGION env var) region.
  # But you may specify it as code here, if you prefer.
  # region = "us-east-1"
}
data "aws_region" "current" {}
