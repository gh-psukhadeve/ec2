
variable "vpc" {
  description = "Name of the host VPC"
  default     = "vpc-eks-test"
}
variable "region" {
  type        = string
  description = "name of region"
}
variable "eks_name" {
  description = "Elastic Kubernetes name"
  type        = string
  default     = "portal-dev01-eks-cluster01"
}
variable "load_balancer_type" {
  type        = string
  description = "load balancer type eg: application"
}

variable "sg_whitelist" {
  type    = list(string)
  default = []
}
variable "alb_name" {
  type        = string
  description = "alb name"
  default     = ""
}
variable "enable_deletion_protection" {
  type        = bool
  description = "enable_deletion_protection value "
}
variable "internal" {
  type        = bool
  description = "oolean determining if the load balancer is interna"
}
variable "create_lb" {
  type = bool
  description = "Controls if the Load Balancer should be created"
  
}
variable "idle_timeout" {
  type = number 
  description = "The time in seconds that the connection is allowed to be idle."
  
}
variable "ip_address_type" {
  type = string
  description = "The type of IP addresses used by the subnets for your load balancer. "
}
variable "load_balancer_create_timeout" {
  type = string
  description = "Timeout value when creating the ALB."
  
}
variable "load_balancer_delete_timeout" {
  type = string
  description = "Timeout value when deleting the ALB."
  
}
variable "load_balancer_update_timeout" {
  type = string
  
}
variable "tags" {
  type = map(string)
}
variable "name" {
    type = string
    description = "name of target group"
}
variable "port" {
  type = number
  description = "port number"
}
