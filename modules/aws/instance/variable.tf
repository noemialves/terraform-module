variable "image" {}
variable "instance_type" {}
variable "key_name_ec2" {}
variable "zone1" {}
variable "zone2" {}

#NETWORK
variable "sub_app_id" {}
variable "sub_app2_id" {}
variable "vpc_id" {}

##AUTOSCALING
variable "max_scaling" {}
variable "min_size" {}
variable "desired_capacity" {}
variable "health_check_grace_period" {}
variable "health_check_type" {}

##LOAD BALANCER
variable "lb_type" {}

variable "env" {}
variable "project_name" {}
variable "tags" {}

