module "my_vpc" {
  source   = "../Modules/Network"
  vpc_cidr = "10.0.0.0/24"
}

module "my_ec2" {
  source             = "../Modules/Ec2"
  instance_count     = 1
  ami_id             = "ami-0ac019f4fcb7cb7e6"
  security_group_ids = "${module.my_vpc.mysecurity_group}"
  subnet1            = "${module.my_vpc.subnet1}"
  key_name           = "deployer_key"
  public_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDqi3cBmPGz+71PorN2ct3LNuDja4ROFAQenXLesrFlaffuudw0PvvETINT3ZKNgBV5CY7BRacmErBm/9dCbX0WGR7stiv4pWT7+oNlDqTuEWj9FQ7EzknkE8tDXi+1uDhmSK1ylPm20pn6gs+7nfdUqzf+Q46YydmBWjbdmkYbcmll0OmxCHSYWfu6QKRACZ/G8tIUNWVZguLrC1FmjjXlI6y047LAlyxqrmlFwubZSMRJL6RgMB1mcmAdW/FjEvvfRXwDc5v5gHShLRlwuIC9i+OSRCMpo8CC5UInCg4wQXWv9UBjPM7OQJKqyxIC68u5M8m6I4/0mdCGrks9DxFu9ggI+0rEgkd2eOD8TwRk5z1EGUA9lFQYlmf8M3igmNKBepAqiBNYcaYyVAWZ0DOh3U/O5dmF7gz8uUC5Z2IcLj9CqpnQSzOMFtjaNe4JcBq2S3ntZWVpCqCb1Jxdk4TAit02zkWfpcJqMjx6khvTZIygNIGAiIZZm4Pp6P+ehTE6ASS+gakC2sK7q+9ux/3TrVn6eqdoui5KDdyQN6OsVF6vFXI3xk+Gk8iGC1QTd7Z47/DvRbikH1AUQw/SZMbT4qy5a7ANJvB0KZ2DY1zwqUcg599OxJ97PMTOqG93dKP+UoG2pDHccI5yyLKhBqpiVIQgZinlodrXvltfelFLQQ== vinay"
}

module "elb_http" {
  source             = "../Modules/Ec2"
  subnet1            = "${module.my_vpc.subnet1}"
  security_group_ids = "${module.my_vpc.mysecurity_group}"
  
  listener = [
    {
       instance_port      = "80"
       instance_protocol  = "HTTP"
       lb_port            = "80"
       lb_protocol        = "HTTP"
    },
    ]

   health_check = {
       target             = "HTTP:80/"
       interval           = 30
       healthy_threshold  = 2
       unhealthy_threshold = 2
       timeout             = 5
}

   #access_logs = {
  #  bucket = "my-access-logs-bucket"
 #}

  // ELB attachments
  number_of_instances = 2
  instances           = ["i-0fddda6d8ba884df6"]
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}   
