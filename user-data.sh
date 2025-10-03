#!/bin/bash

# Update and install HAProxy
yum update -y
yum install -y haproxy

# Install Docker
yum install -y docker
systemctl start docker
systemctl enable docker

# Start HAProxy
systemctl start haproxy
systemctl enable haproxy

# Create PHP application
mkdir -p /opt/app
cd /opt/app

cat > index.php << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Load Balancer Lab</title>
</head>
<body>
    <h2>Welcome to the Load Balancer Application</h2>
    <?php
        $hostname = $_ENV['HOSTNAME'];
        echo "<p>You are redirected to <b>$hostname</b> to see load balancing in action!</p>";
    ?>
</body>
</html>
EOF

cat > Dockerfile << 'EOF'
FROM php:7.4-apache
COPY index.php /var/www/html/
EXPOSE 80
EOF

# Build and run web servers
docker build -t php-app .

docker run -d --hostname webserver1 --name web1 -p 8000:80 php-app
docker run -d --hostname webserver2 --name web2 -p 8005:80 php-app

# Wait for containers
sleep 20

# Configure HAProxy
cat > /etc/haproxy/haproxy.cfg << 'EOF'
global
    daemon
    maxconn 256

defaults
    mode http
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms

frontend http-in
    bind *:80
    default_backend webservers

backend webservers
    balance roundrobin
    option httpchk
    option forwardfor
    server web1 172.17.0.2:80 check
    server web2 172.17.0.3:80 check

listen admin
    bind *:8080
    stats enable
EOF

# Restart HAProxy
systemctl restart haproxy

echo "HAProxy Load Balancer setup complete!"