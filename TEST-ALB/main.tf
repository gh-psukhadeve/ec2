terraform {
  required_version = ">= 0.12.31"
}

provider "aws" {
  region = var.region
}

data "aws_vpc" "selected" {
  tags = {
    Name = var.vpc
  }
}

data "aws_subnets" "selected" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc}-private-*"]
  }
}
resource "aws_db_subnet_group" "selected" {
  name       = "main-sg"
  subnet_ids = data.aws_subnets.selected.ids

  tags = {
    Name = var.alb_name
  }
}

data "aws_eks_cluster" "selected" {
  name = var.eks_name
}

resource "aws_security_group" "alb-sg" {
  name        = "terraform-alb_sg-${var.alb_name}"
  description = "Allow alb inbound traffic"
  vpc_id      = data.aws_vpc.selected.id
  
  ingress {
    from_port   = 80
    to_port     = 81
    protocol    = "tcp"
    cidr_blocks = concat(var.sg_whitelist, [data.aws_eks_cluster.selected.kubernetes_network_config[0].service_ipv4_cidr])
  }
}

resource "aws_lb_target_group" "tcw_tg" {
  name     = var.name
  port     = var.port
  protocol = "HTTP" 
  vpc_id   = data.aws_vpc.selected.id
}

/*resource "aws_lb_listener" "alb_forward_listener" {
load_balancer_arn = aws_lb.tcw_alb.arn
port = "80"
protocol = "HTTP"
default_action {
type = "forward"
target_group_arn = aws_lb_target_group.tcw_tg.arn
}
}*/




module "alb"{
  
  source             = "HDE/alb/aws"
  version            = "6.3.0"
  name               = var.alb_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  subnets                    = data.aws_subnets.selected.ids
  security_groups          = [aws_security_group.alb-sg.id]
  enable_deletion_protection = var.enable_deletion_protection
  create_lb = var.create_lb
  idle_timeout = var.idle_timeout
  ip_address_type = var.ip_address_type 
  load_balancer_create_timeout = var.load_balancer_create_timeout
  load_balancer_delete_timeout = var.load_balancer_delete_timeout
  load_balancer_update_timeout = var.load_balancer_update_timeout

}

  