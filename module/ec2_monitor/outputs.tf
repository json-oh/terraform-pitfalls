output "ec2_monitor_queue_arn" {
  value = aws_sqs_queue.ec2_monitor.arn
}
