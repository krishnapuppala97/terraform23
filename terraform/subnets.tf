#subnets
resource "aws_subnet" "public_subenet" {
  vpc_id     = aws_vpc.vpc.id
  count = length(var.public_subenets_cidr)
  cidr_block = var.public_subenets_cidr[count.index]
  map_public_ip_on_launch = true
   availability_zone = var.azs[count.index]

  tags = var.tags
}

 

resource "aws_subnet" "private_subenet" {
  vpc_id     = aws_vpc.vpc.id
  count = length(var.private_subenets_cidr)
  cidr_block = var.private_subenets_cidr[count.index]
  map_public_ip_on_launch = false
  availability_zone = var.azs[count.index]

  tags = var.tags
}

#elastic_ip
resource "aws_eip" "EIP" {
  vpc = true
}

#nat gateway
resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.EIP.id
  subnet_id     = aws_subnet.public_subenet[1].id

  tags = {
    Name = "gw NAT"
  }
  depends_on = [aws_internet_gateway.igw]
}
#route table association 
resource "aws_route_table_association" "public_association" {
  count = length(var.public_subenets_cidr)
  subnet_id      = aws_subnet.public_subenet[count.index].id
  route_table_id = aws_route_table.public_route.id
}



resource "aws_route_table_association" "private_association" {
  count = length(var.private_subenets_cidr)
  subnet_id      = aws_subnet.private_subenet[count.index].id
  route_table_id = aws_route_table.private_route.id
}