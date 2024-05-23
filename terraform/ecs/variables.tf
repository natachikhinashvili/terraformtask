variable "security_group_id" {
  description = "The security group ID to associate with the load balancer"
  type        = string
}

variable "vpc_id" {
  description = "The vpc ID to associate with the load balancer"
  type        = string
  default = "vpc-0fd52b514d0d10d80"
}

variable "aws_lb_target_group_arn" {
  description = "target group arn"
  type        = string
}
