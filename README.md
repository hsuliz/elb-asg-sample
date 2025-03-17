# elb-asg-sample

AWS Elastic Load Balancer with Autoscaling Group using Terraform.

## Description

The Load Balancer distributes incoming traffic to an Auto Scaling Group of instances. \
Server can be used to monitor which instance receives traffic from the Load Balancer and to perform stress tests,
verifying the Auto Scaling policy in action.

## File structure

- `src/` contains golang server which have 2 API endpoints:
    1. `GET /` get information about server
    2. `POST /high-load` loads server by calculating float numbers. Body must contain `power` which is `int`
- `terraform/` IaC which creating:
    1. Load Balancer
    2. Autoscaling Group
    3. Security group
    4. Outputs LoadBalancer IP address
- `Dockerfile` containerization for server
- `makefile` for server building
