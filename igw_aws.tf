resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.vpc_main.id}"

  tags {
    Name = "My GW"
  }
}
