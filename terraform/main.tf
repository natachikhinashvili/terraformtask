module "security_group" {
    source = "./security_group"

  security_group_id = module.security_group.security_group_id
  vpc_id =var.vpc_id
}

module "ecs" {
  source             = "./ecs"
  security_group_id = module.security_group.security_group_id
  vpc_id = var.vpc_id
  aws_lb_target_group_arn = module.load_balancer.aws_lb_target_group_arn
}

module "load_balancer" {
  source             = "./alb"
  security_group_id = module.security_group.security_group_id
  vpc_id = var.vpc_id
}
