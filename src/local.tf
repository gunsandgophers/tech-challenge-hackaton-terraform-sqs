locals {
  name   = "tech-challenge-hackaton-rds"
  region = "us-east-1"

  engine         = "postgres"
  engine_version = "16"
  family         = "postgres16"
  instance_class = "db.t3.micro"

  db_name     = "tech_challenge_hackaton"
  db_username = "tech_challenge_hackaton"

}
