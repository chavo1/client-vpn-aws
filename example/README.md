# This example contains a terraform code which call module and create client vpn endpoint in AWS

## How to use it:
- A following component:
  - | [Terraform](https://www.terraform.io/)
- You must also have an AWS account, also please check [AWS Client VPN pricing](https://aws.amazon.com/vpn/pricing/)
- Clone the repo:
```
git clone https://github.com/chavo1/client-vpn-aws-terraform.git
cd client-vpn-aws-terraform/example
```
- Update "example.tfvars" file with needed credential and variables.

### Start with deploying process
```
terraform init
terraform plan
terraform apply
```
### Do not forget to destroy the environment after the test
```
terraform destroy
```

### To test the module you will need Kitchen:

Kitchen is a RubyGem so please find how to install and setup Test Kitchen, check out the [Getting Started Guide](http://kitchen.ci/docs/getting-started/).
For more information about kitchen tests please check the next link:

https://kitchen.ci/docs/getting-started/running-test/

Than simply execute a following commands:
```
bundle exec kitchen converge
bundle exec kitchen verify
kbundle exec kitchen destroy
```