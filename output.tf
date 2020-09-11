output "client_vpn_endpoint" {
  value = aws_ec2_client_vpn_endpoint.Virginia.id
}

output "client_vpn_network_association" {
  value = aws_ec2_client_vpn_network_association.association.status
}