resource "aws_internet_gateway" "ig_vpc" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "ig-vpc"
  }
}

# Add elastic ip for NAT
resource "aws_eip" "nat_eip" {
  vpc      = true
}

# Add public NAT connected to public subnet for private traffic
resource "aws_nat_gateway" "nat_vpc" {
  allocation_id     = aws_eip.nat_eip.id
  subnet_id         = aws_subnet.pub_subnet.id

  tags = {
    Name = "nat-vpc"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.ig_vpc]
}