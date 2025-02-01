module "process-video-queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "4.2.1"

  name = "process-video-queue"

  create_dlq = true

  tags = {
    Environment = "dev"
  }
}

module "result-video-queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "4.2.1"

  name = "result-video-queue"

  create_dlq = true

  tags = {
    Environment = "dev"
  }
}

