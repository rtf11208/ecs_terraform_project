#!/bin/bash
    sudo yum update
    sudo yum install -y https://s3.region.amazonaws.com/amazon-ssm-region/latest/linux_amd64/amazon-ssm-agent.rpm
    systemctl enable amazon-ssm-agent
    systemctl start amazon-ssm-agent
    sudo yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    cd var/www/html
    echo "<html><body><h1>Deployed via Terraform</h1></body></html>">index.html