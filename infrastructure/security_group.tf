resource "aws_security_group" "bastion_host_sg" {
  name        = "bastion_host_sg"
  description = "Allow access to this server only from local machine"
  vpc_id      = aws_vpc.vpc.id

  # INBOUND CONNECTIONS
  ingress {
    description = "Allow SSH into the EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #[var.my_local_pub_ip]
  }

  ingress {
    description = "Allow HTTP into the EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks =  ["0.0.0.0/0"] #[var.my_local_pub_ip]
  }

  # OUTBOUND CONNECTIONS
  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }

  depends_on = [
    aws_vpc.vpc,
    aws_subnet.priv_subnet_1,
    aws_subnet.priv_subnet_2,
    aws_subnet.pub_subnet
  ]
}

resource "aws_security_group" "db_movie_sg" {
  name        = "db_movie_sg"
  description = "Securtiy group for MySQL Database"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow access to mysql db"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_host_sg.id]
  }

  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # TCP + UDP
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database-security-group"
  }

  depends_on = [
    aws_vpc.vpc,
    aws_subnet.priv_subnet_1,
    aws_subnet.priv_subnet_2,
    aws_subnet.pub_subnet,
    aws_security_group.bastion_host_sg
  ]
}