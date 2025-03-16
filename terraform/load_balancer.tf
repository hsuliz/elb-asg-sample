resource "aws_lb" "this" {
  name = "lb-sample"
  tags = {
    name : "elb-asg-sample"
  }

  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  subnets            = data.aws_subnets.this.ids
  security_groups    = [aws_security_group.load_balancer.id]
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  tags = {
    name : "elb-asg-sample"
  }

  protocol = "HTTP"
  port     = "80"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  name_prefix = "lb-smp"
  tags = {
    name : "elb-asg-sample"
  }

  protocol = "HTTP"
  port     = 80
  vpc_id   = data.aws_vpc.this.id

  lifecycle {
    create_before_destroy = true
  }
}