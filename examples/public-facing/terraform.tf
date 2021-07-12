provider "aws" {
    region = "us-west-1"
}

terraform {
  backend "s3" {
    bucket         = "tamr-tfstate-bucket-franco-networking-2021-06-28"
    dynamodb_table = "tamr-tfstate-locking-franco-networking-2021-06-28"

    encrypt = "true"
    key     = "tamr-public-facing.tfstate"
    region  = "us-west-1"
    profile = "default"
  }
}
