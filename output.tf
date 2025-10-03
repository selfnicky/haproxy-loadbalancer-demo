output "server_ip" {
  value = aws_lightsail_instance.haproxy_server.public_ip_address
}

output "application_url" {
  value = "http://${aws_lightsail_instance.haproxy_server.public_ip_address}"
}

output "stats_url" {
  value = "http://${aws_lightsail_instance.haproxy_server.public_ip_address}:8080"
}

output "web1_url" {
  value = "http://${aws_lightsail_instance.haproxy_server.public_ip_address}:8000"
}

output "web2_url" {
  value = "http://${aws_lightsail_instance.haproxy_server.public_ip_address}:8005"
}

output "ssh_command" {
  value = "ssh -i haproxy-key-${random_id.suffix.hex}.pem ec2-user@${aws_lightsail_instance.haproxy_server.public_ip_address}"
}