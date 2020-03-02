# Build dependecies for the example.
resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "EKS Example VPC"
  }

  lifecycle {
    ignore_changes = ["tags"]
  }
}

resource "aws_subnet" "private1" {
  cidr_block        = "10.0.2.0/24"
  vpc_id            = "${aws_vpc.test_vpc.id}"
  availability_zone = "ap-southeast-2a"

  tags {
    Name = "EKS Example Private Subnet"
  }

  lifecycle {
    ignore_changes = ["tags"]
  }
}

resource "aws_subnet" "private2" {
  cidr_block        = "10.0.0.0/24"
  vpc_id            = "${aws_vpc.test_vpc.id}"
  availability_zone = "ap-southeast-2b"

  tags {
    Name = "EKS Example Private Subnet"
  }

  lifecycle {
    ignore_changes = ["tags"]
  }
}

resource "aws_subnet" "private3" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = "${aws_vpc.test_vpc.id}"
  availability_zone = "ap-southeast-2c"

  tags {
    Name = "EKS Example Private Subnet"
  }

  lifecycle {
    ignore_changes = ["tags"]
  }
}

resource "aws_subnet" "public1" {
  cidr_block        = "10.0.4.0/24"
  vpc_id            = "${aws_vpc.test_vpc.id}"
  availability_zone = "ap-southeast-2c"

  tags {
    Name = "EKS Example Public Subnet"
  }

  lifecycle {
    ignore_changes = ["tags"]
  }
}

resource "aws_subnet" "public2" {
  cidr_block        = "10.0.5.0/24"
  vpc_id            = "${aws_vpc.test_vpc.id}"
  availability_zone = "ap-southeast-2b"

  tags {
    Name = "EKS Example Public Subnet"
  }

  lifecycle {
    ignore_changes = ["tags"]
  }
}

resource "aws_subnet" "public3" {
  cidr_block        = "10.0.6.0/24"
  vpc_id            = "${aws_vpc.test_vpc.id}"
  availability_zone = "ap-southeast-2a"

  tags {
    Name = "EKS Example Public Subnet"
  }

  lifecycle {
    ignore_changes = ["tags"]
  }
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.test_vpc.id}"
}

resource "aws_nat_gateway" "this" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public1.id}"

  depends_on = ["aws_internet_gateway.gateway"]
}

resource "aws_route_table" "public-router" {
  vpc_id = "${aws_vpc.test_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gateway.id}"
  }

  tags {
    Name = "Public Subnet"
  }
}

resource "aws_route_table" "private-router" {
  vpc_id = "${aws_vpc.test_vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.this.id}"
  }

  tags {
    Name = "Private Subnet"
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = "${aws_subnet.public1.id}"
  route_table_id = "${aws_route_table.public-router.id}"
}

resource "aws_route_table_association" "public2" {
  subnet_id      = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.public-router.id}"
}

resource "aws_route_table_association" "public3" {
  subnet_id      = "${aws_subnet.public3.id}"
  route_table_id = "${aws_route_table.public-router.id}"
}

resource "aws_route_table_association" "private1" {
  subnet_id      = "${aws_subnet.private1.id}"
  route_table_id = "${aws_route_table.private-router.id}"
}

resource "aws_route_table_association" "private2" {
  subnet_id      = "${aws_subnet.private2.id}"
  route_table_id = "${aws_route_table.private-router.id}"
}

resource "aws_route_table_association" "private3" {
  subnet_id      = "${aws_subnet.private3.id}"
  route_table_id = "${aws_route_table.private-router.id}"
}
