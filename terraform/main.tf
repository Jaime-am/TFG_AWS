provider "aws" {
  //variables a cambiar en vars.tf
  //son las credenciales de acceso a nuestro AWS
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}
resource "aws_vpc" "VPC_TFG" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC_EC2_TFG"
  }
}

resource "aws_subnet" "subnet_TFG" {
  cidr_block = "10.0.1.0/24"
  vpc_id = "${aws_vpc.VPC_TFG.id}"
  tags = {
    Name = "Subnet_EC2_TFG"
  }
}

resource "aws_internet_gateway" "IG_TFG" {
  vpc_id = "${aws_vpc.VPC_TFG.id}"
  tags = {
    Name = "GW_EC2_TFG"
  }
}

resource "aws_route_table" "RT_TFG" {
  vpc_id = "${aws_vpc.VPC_TFG.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.IG_TFG.id}"
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = "${aws_subnet.subnet_TFG.id}"
  route_table_id = "${aws_route_table.RT_TFG.id}"
}

resource "aws_security_group" "SG_TFG" {
  vpc_id = "${aws_vpc.VPC_TFG.id}"
  name = "SecurityGroup_EC2_TFG"

//puertos a abrir en la EC2
  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "22"
    to_port     = "22"
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "80"
    to_port     = "80"
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "443"
    to_port     = "443"
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "8080"
    to_port     = "8080"
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "9080"
    to_port     = "9080"
  }

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    to_port     = "0"
  }

}

resource "aws_network_interface" "NI_TFG" {
   subnet_id       = aws_subnet.subnet_TFG.id
   private_ips     = ["10.0.1.60"]
   security_groups = [aws_security_group.SG_TFG.id]

 }

 resource "aws_eip" "EIP_TFG" {
   vpc                       = true
   network_interface         = aws_network_interface.NI_TFG.id
   associate_with_private_ip = "10.0.1.60"
   depends_on                = [aws_internet_gateway.IG_TFG]
 }


resource "aws_instance" "TFG" {
    
    instance_type = "t2.micro"
    ami = "${var.ami}"
    key_name = "${var.key_pair}"
    network_interface {
     device_index         = 0
     network_interface_id = aws_network_interface.NI_TFG.id
   }
   //codigo que se ejecutara nada mas crear la instancia
   //ejecuta el script setup.sh de mi github
     user_data = <<-EOF
        #!/bin/bash
        sudo apt update
        sudo apt install git -y
        git clone https://github.com/Jaime-am/TFG_AWS/
        chmod +x TFG_AWS/setup.sh
        bash TFG_AWS/setup.sh
        EOF

    tags = {
        name = "EC2_TFG"
    }
}