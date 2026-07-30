
/* Creating a VPC, Subnet, Internet Gateway, Route Table, 
Security Group, and EC2 instance using Terraform */

provider "aws" {
  region     = "us-east-1"
  
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

/* Creating subnet in order to launch EC2 instance in 
the VPC, and associating it with a route table and internet gateway */

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a" 
  map_public_ip_on_launch = true

  tags = {
    Name = "main_subnet"
  }
}

/* Creating an internet gateway to allow 
the EC2 instance to access the internet */

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main_igw"
  }
}

/* Creating a route table in order to allow
 the EC2 instance to access the internet */

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "main_rt"
  }
}

/* Associating the route table with the subnet to allow
 the EC2 instance to access the internet through the 
 internet gateway */

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id

}

/* Creating a security group to allow SSH and 
HTTP access to the EC2 instance. Would never allow SSH or HTTP
from anywhere in a production environment would set specific 
IP ranges, but for the sake of this project, I will allow it 
from anywhere */

resource "aws_security_group" "jordon_sg" {
    name        = "jordon_sg"
    description = "Allow SSH and HTTP"
    vpc_id      = aws_vpc.main.id
    

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] /* <== Real world would set specific IP ranges */
    }


    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] /* <== Real world would set specific IP ranges */
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"] /* <== Real world would set specific IP ranges */
    }
    tags = {
        Name = "jordon_sg"
    }
}

/* Creating EC2 instance using terraform */

resource "aws_instance" "jordon_ec2" {
    ami = "ami-02b64aa047cb5edf5"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.main.id
    vpc_security_group_ids = [aws_security_group.jordon_sg.id]

    tags = {
        Name = "Jordon-EC2"
    }
}

