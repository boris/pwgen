terraform {
  backend "s3" {
    bucket  = "btmn-terraform-endless-heron"
    key     = "pwgen.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
provider "aws" {
  region = var.region
}

resource "random_pet" "s3_bucket_name" {
  prefix = "btmn-terraform"
  length = 2
}

resource "aws_s3_bucket" "terraform_bucket" {
  bucket = random_pet.s3_bucket_name.id
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      bucket_key_enabled = true

      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
