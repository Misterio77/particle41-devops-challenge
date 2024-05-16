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

provider "aws" {}

# If you want, you can manage the bucket itself with terraform
# Do keep in mind 'terraform destroy' might take your state with it, and risk
# leaving you with some dangling resources to be removed manually.
# resource "aws_s3_bucket" "tfstate" {}
