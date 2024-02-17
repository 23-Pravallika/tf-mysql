## Creates Security Group 
resource "aws_security_group" "allow-mysql" {
 name        = "robo-${var.ENV}-mysql-sg"
 description = "Allows mysql Internal inbound traffic"
 vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID 
 
ingress {
   description = "Allows mysql from local network"
   from_port   = 3306
   to_port     = 3306
   protocol    = "tcp"
   cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
 }

ingress {
   description = "Allows mysql from default network"
   from_port   = 3306
   to_port     = 3306
   protocol    = "tcp"
   cidr_blocks = [data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
 }

egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

tags = {
    Name = "allow-mysql"
  }
}


