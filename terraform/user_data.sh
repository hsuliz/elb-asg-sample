#!/bin/bash
sudo dnf update -y
sudo dnf install -y docker
sudo systemctl enable --now docker

sudo docker run --platform linux/amd64 -d -h "$(hostname)" -p 80:8080 hsuliz/elb-asg-sample:latest
