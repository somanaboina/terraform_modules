provider "aws" {
  region  = "us-east-1"
#  profile = "my_profile"
access_key = "AKIARZC67HZEYPHYSKP4"
secret_key = "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"
}
terraform {
  backend "s3" {
    bucket = "somanaterraformbucket"
    key    = "devmodules.tfstate"
    region = "us-east-1"
  }
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }
}
