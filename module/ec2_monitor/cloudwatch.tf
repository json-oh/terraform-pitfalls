resource "aws_cloudwatch_event_rule" "ec2_state_to_sqs" {
  name        = "${var.environment}-ec2-state-to-sqs"
  description = "Capture State Change from EC2 Instance."

  tags = merge(local.tags, {
    Type = "event_rule"
  })

  event_pattern = <<PATTERN
{
  "source": [
    "aws.ec2"
  ],
  "detail-type": [
    "EC2 Instance State-change Notification"
  ]
}
PATTERN
}

resource "aws_cloudwatch_event_target" "sqs" {
  rule = aws_cloudwatch_event_rule.ec2_state_to_sqs.id
  arn  = aws_sqs_queue.ec2_monitor.arn
}
