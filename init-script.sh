#!/bin/bash
sudo apt-get update -y
sudo apt-get -y install nginx curl
sudo nginx -t
sudo systemctl restart nginx
