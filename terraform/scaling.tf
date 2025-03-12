resource "aws_autoscaling_group" "this" {
  name_prefix = "myserver"

  desired_capacity = 2
  max_size         = 2
  min_size         = 2

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
  name_prefix = "elb-asg-sample"
  tags = {
    name : "elb-asg-sample"
  }

  instance_type = "t2.micro"
  image_id      = "ami-06ee6255945a96aba"
  key_name      = "ec2-tutorial"

  vpc_security_group_ids = [aws_security_group.launch_template.id]
}