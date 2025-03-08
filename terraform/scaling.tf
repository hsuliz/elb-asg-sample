resource "aws_autoscaling_group" "this" {
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
  user_data = base64encode(<<EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Helelo from $(hostname -f)</h1>" > /var/www/html/index.html
  EOF
  )
}