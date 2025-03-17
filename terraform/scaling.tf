resource "aws_autoscaling_group" "this" {
  name = "autoscaling-group-sample"
  tag {
    key                 = "name"
    value               = "elb-asg-sample"
    propagate_at_launch = true
  }

  desired_capacity  = var.min_size
  min_size          = var.min_size
  max_size          = var.max_size
  health_check_type = "ELB"

  vpc_zone_identifier = data.aws_subnets.this.ids
  target_group_arns = [
    aws_lb_target_group.this.arn
  ]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
}

resource "aws_launch_template" "this" {
  name = "elb-asg-sample"
  tags = {
    name : "elb-asg-sample"
  }

  instance_type = var.instance_type
  image_id      = var.image_id
  key_name      = var.ssh_key_name

  vpc_security_group_ids = [aws_security_group.launch_template.id]
  user_data = filebase64("${path.module}/user_data.sh")
}

resource "aws_autoscaling_policy" "this" {
  name                   = "dynamic-scaling-policy-sample"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.this.name

  estimated_instance_warmup = 70
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60.0
  }
}

resource "aws_autoscaling_lifecycle_hook" "this" {
  name                   = "keep-alive-hook-sample"
  autoscaling_group_name = aws_autoscaling_group.this.name
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
  heartbeat_timeout      = 300
  default_result         = "CONTINUE"
}
