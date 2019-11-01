provider "aws" {
  profile = "portiz"
  region  = "us-east-1"
}

module "state-bucket" {
  source      = "../modules/s3/"
  bucket-name = "family-apps-state-bucket"
  bucket-acl  = "private"
}
