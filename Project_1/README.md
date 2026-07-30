This project shows the following:


**EC2 Instances**

Ability to create an EC2 instance



**VPC**

Attach a custom VPC to the EC2


**Internet Gateway**

Create an internet gateway in order to allow the EC2 to gain access to the internet


**Subnet Routing**

Associate a routing table to a subnet in order to allow internet access to the EC2 through the internet gateway


**IP Access Control**

Create ingress and egress rules to allow SSH and HTTP access to the EC2 from specific IP addreses


**IAM Users & Groups**

Extract data from a csv that contains multiple different attributes and create multiple organizational groups to assign individuals based on their attributes


## Local Setup Instructions

When working with this repository locally, you will need to have Terraform installed on your computer. Instructions can be found here:
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

Once installed, run the following command:

```terraform init```