resource "aws_sqs_queue" "ec2_monitor" {
  name           = "${var.environment}-ec2-monitor"
  redrive_policy = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.ec2_monitor_dlq.arn}\",\"maxReceiveCount\":4}"

  tags = merge(local.tags, {
    Type = "normal"
  })
}

resource "aws_sqs_queue" "ec2_monitor_dlq" {
  name = "${var.environment}-ec2-monitor-dlq"

  tags = merge(local.tags, {
    Type = "dlq"
  })
}

resource "aws_sqs_queue_policy" "ec2_monitor_queue_policy" {
  queue_url = aws_sqs_queue.ec2_monitor.id
  policy    = data.aws_iam_policy_document.ec2_monitor_queue_policy_doc.json
}

data "aws_iam_policy_document" "ec2_monitor_queue_policy_doc" {
  policy_id = "${aws_sqs_queue.ec2_monitor.arn}/SQSDefaultPolicy"

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    actions = [
      "sqs:SendMessage",
    ]

    resources = [
      aws_sqs_queue.ec2_monitor.arn
    ]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = [
        aws_cloudwatch_event_rule.ec2_state_to_sqs.arn
      ]
    }
  }
}
