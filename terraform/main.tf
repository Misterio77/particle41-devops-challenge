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

resource "aws_s3_bucket" "tfstate" {}

provider "aws" {}
