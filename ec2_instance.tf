resource "aws_instance" "instance" {
  count                  = 1
  instance_type          = "t2.micro"
  ami                    = "ami-07ebfd5b3428b6f4d"
  key_name               = "${aws_key_pair.deployer.key_name}"
  user_data              = "${file("install_nginx.sh")}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  subnet_id              = "${aws_subnet.subnet1.id}"

  root_block_device {
    volume_size = 8
  }


  tags {
    Name = "Ec2-WebServer"
  }
 }
