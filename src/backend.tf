terraform {
  backend "s3" {
    bucket = "tech-challenge-hackaton"
    key    = "sqs/terraform.tfstate"
    region = "us-east-1"
  }
}
