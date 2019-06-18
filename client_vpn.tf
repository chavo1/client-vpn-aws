// We need an AWS credentials
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

// client_vpn_endpoint
resource "aws_ec2_client_vpn_endpoint" "Virginia" {
  description            = "clientvpn"
  server_certificate_arn = "${var.server_certificate_arn}"
  client_cidr_block      = "${var.client_cidr_block}"

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = "${var.root_certificate_chain_arn}"
  }

  connection_log_options {
    enabled = false
  }
}

// associate vpn network
resource "aws_ec2_client_vpn_network_association" "association" {
  client_vpn_endpoint_id = "${aws_ec2_client_vpn_endpoint.Virginia.id}"
  subnet_id              = "${var.vpc_subnet}"
}

// authorize client vpn ingress with awscli
resource "null_resource" "authorize" {
  provisioner "local-exec" {
    command = "echo -ne '\n' | aws ec2 authorize-client-vpn-ingress --client-vpn-endpoint-id ${aws_ec2_client_vpn_endpoint.Virginia.id} --target-network-cidr 0.0.0.0/0 --authorize-all-groups"
  }
  depends_on = ["${aws_ec2_client_vpn_network_association.association}"]
}

// export vpn config
resource "null_resource" "config" {
  provisioner "local-exec" {
    command = "aws ec2 export-client-vpn-client-configuration --client-vpn-endpoint-id ${aws_ec2_client_vpn_endpoint.Virginia.id} >> config-cvpn.ovpn"
  }
  depends_on = ["${aws_ec2_client_vpn_network_association.association}"]
}

// add client vpn route
resource "null_resource" "route" {
  provisioner "local-exec" {
    command = "aws ec2 create-client-vpn-route --client-vpn-endpoint-id ${aws_ec2_client_vpn_endpoint.Virginia.id} --destination-cidr-block ${var.destination_cidr_block} --target-vpc-subnet-id ${var.destination_subnet}"
  }
  depends_on = ["${aws_ec2_client_vpn_network_association.association}"]
}


