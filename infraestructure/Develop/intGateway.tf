resource "aws_internet_gateway" "web_igw" {
  vpc_id = aws_vpc.web.id
  tags = {
    Name = "web-igw"
  }
}

resource "aws_route_table" "web_rt" {
  vpc_id = aws_vpc.web.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web_igw.id
  }
}

resource "aws_route_table_association" "web_sub_1" {
  subnet_id      = aws_subnet.web_sub_1.id
  route_table_id = aws_route_table.web_rt.id
}

resource "aws_route_table_association" "web_sub_2" {
  subnet_id      = aws_subnet.web_sub_2.id
  route_table_id = aws_route_table.web_rt.id
}

resource "aws_route_table_association" "web_sub_3" {
  subnet_id      = aws_subnet.web_sub_3.id
  route_table_id = aws_route_table.web_rt.id
}