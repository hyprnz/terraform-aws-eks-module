# Build dependecies for the example.
resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private1" {
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.test_vpc.id
  availability_zone = "ap-southeast-2a"
}

resource "aws_subnet" "private2" {
  cidr_block        = "10.0.0.0/24"
  vpc_id            = aws_vpc.test_vpc.id
  availability_zone = "ap-southeast-2b"
}

resource "aws_subnet" "private3" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.test_vpc.id
  availability_zone = "ap-southeast-2c"
}

resource "aws_subnet" "public1" {
  cidr_block        = "10.0.4.0/24"
  vpc_id            = aws_vpc.test_vpc.id
  availability_zone = "ap-southeast-2c"
}

resource "aws_subnet" "public2" {
  cidr_block        = "10.0.5.0/24"
  vpc_id            = aws_vpc.test_vpc.id
  availability_zone = "ap-southeast-2b"
}

resource "aws_subnet" "public3" {
  cidr_block        = "10.0.6.0/24"
  vpc_id            = aws_vpc.test_vpc.id
  availability_zone = "ap-southeast-2a"
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.test_vpc.id
}

resource "aws_route_table" "public-router" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "Public Subnet"
  }
}

