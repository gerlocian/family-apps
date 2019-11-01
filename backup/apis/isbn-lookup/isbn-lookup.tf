provider "aws" {
  profile = "portiz"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    profile = "portiz"
    region  = "us-east-1"
    bucket  = "family-apps-state-bucket"
    key     = "isbn-lookup-api"
  }
}