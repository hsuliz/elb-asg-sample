resource "aws_security_group" "load_balancer" {
  vpc_id = data.aws_vpc.this.id

  name = "load-balancer-sg"
  tags = {
    name : "elb-asg-sample"
  }
}

resource "aws_security_group" "launch_template" {
  vpc_id = data.aws_vpc.this.id

  name = "launch-template-sg"
  tags = {
    name : "elb-asg-sample"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_http_traffic_ipv4" {
  security_group_id = aws_security_group.load_balancer.id

  description = "Allow all HTTP traffic IPv4"
  tags = {
    name : "elb-asg-sample"
  }

  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_traffic_ipv4" {
  security_group_id = aws_security_group.launch_template.id

  description = "Allow all SSH traffic IPv4"
  tags = {
    name : "elb-asg-sample"
  }

  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_traffic_ipv4" {
  security_group_id = aws_security_group.launch_template.id

  description = "Allow all HTTP traffic IPv4"
  tags = {
    name : "elb-asg-sample"
  }

  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_lb" {
  security_group_id = aws_security_group.load_balancer.id

  description = "Allow all traffic IPv4 Load Balancer"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_lt" {
  security_group_id = aws_security_group.launch_template.id

  description = "Allow all traffic IPv4 for Launch Template"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}


