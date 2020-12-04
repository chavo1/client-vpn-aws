# vpc subnet 
variable "vpc_subnet" {}

# server credentials
variable "server_certificate_arn" {}
variable "root_certificate_chain_arn" {}

# client CIDR block
variable "client_cidr_block" {}

# destination cidr block
variable "destination_cidr_block" {}

# destination subnet
variable "destination_subnet" {}
