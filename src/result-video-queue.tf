resource "aws_sqs_queue" "result_video_queue" {
  name                      = "result-video-queue"
  max_message_size          = 2048
  message_retention_seconds = 86400
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.result_video_queue_deadletter.arn
    maxReceiveCount     = 10
  })

  tags = {
    Environment = "production"
  }
}

data "aws_iam_policy_document" "result_video_queue_policy" {
  statement {
    sid    = "shsqsstatement"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage"
    ]
    resources = [
      aws_sqs_queue.result_video_queue.arn
    ]
  }
}

resource "aws_sqs_queue_policy" "result_video_queue_policy" {
  queue_url = aws_sqs_queue.result_video_queue.id
  policy    = data.aws_iam_policy_document.result_video_queue_policy.json
}


resource "aws_sqs_queue" "result_video_queue_deadletter" {
  name = "result-video-queue-dlq"
}

resource "aws_sqs_queue_redrive_allow_policy" "result_video_queue_redrive_allow_policy" {
  queue_url = aws_sqs_queue.result_video_queue_deadletter.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.result_video_queue.arn]
  })
}
