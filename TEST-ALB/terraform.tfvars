region                     = "us-west-2"
vpc                        = "vpc-eks-test"
alb_name                   = "test-alb"
load_balancer_type         = "application"

ip_address_type = "ipv4"
name  = "test-TG"
port = 80
enable_deletion_protection = false
internal                   = false
create_lb = true 
idle_timeout = 60
load_balancer_create_timeout= "10m"
eks_name                   = "portal-dev01-eks-cluster01"
load_balancer_delete_timeout = "10m"
load_balancer_update_timeout = "10m"
tags = {
  Env = "test"
}























sg_whitelist = [
  //Guardant
  "10.4.0.0/16",
]

