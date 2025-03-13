#!/bin/bash
sudo dnf update -y
sudo dnf install -y docker
sudo systemctl enable --now docker

sudo docker run -d -p 80:8080 hsuliz/elb-asg-sample:latest