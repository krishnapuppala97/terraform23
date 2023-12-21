resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
    tags =  var.tags
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags =  var.tags
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  
  tags =  var.tags
} 

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id
  route{
    nat_gateway_id = aws_nat_gateway.NAT.id
  }
  
  tags =  var.tags
}
