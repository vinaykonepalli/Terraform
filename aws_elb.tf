resource "aws_elb" "reddy"{
  name                = "vinayreddy-terraform-elb"
  availabilty_zones   = ["us-east-1a", " us-east-1b", "us-east-1c"]

#  access_logs {
 #     bucket         = "vinay"
  #    bucket_prefix  = "reddy"
   #   interval       = 60
#}
  
  listener {
      instance_port       = 80
      instance_protocol   = "HTTP"
      lb_port             = 80
      lb_protocol         = "HTTP"
}

  health_check {
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 3
      target              = "HTTP:80/"
      interval            = 30
}

  instances               = ["${aws_instance.vinay.id}"]
  cross_zone_load_balancing = true
  idle_timeout              = 400
  connection_draining       = true
  connection_draining_timeout = 400

  tags{
    Name = "vinayreddy-terraform-elb"
}
}
   
