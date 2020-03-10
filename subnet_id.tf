# Create a public subnet to launch our Instances
resource "aws_subnet" "subnet1" {
  vpc_id                  = "${aws_vpc.vpc_main.id}"
  cidr_block              = "10.0.0.0/25"            # 10.0.1.0 - 10.0.1.255 (256)
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags {
    Name  = "subnet1"
    Owner = "vinayreddy"
    Zone  = "us-east-1a"
  }
}

# Create a private subnet to launch our backend instances
resource "aws_subnet" "subnet2" {
  vpc_id                  = "${aws_vpc.vpc_main.id}"
  cidr_block              = "10.0.0.128/25"          # 10.0.16.0 - 10.0.31.255 (4096)
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags {
    Name  = "subnet2"
    Owner = "vinayreddy"
    Zone  = "us-east-1b"
  }
}
