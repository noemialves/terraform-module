variable "aws_region" {}
variable "zone1" {}
variable "zone2" {}

##BACKEND
//variable "bucket_key" {}
//variable "bucket_name" {}

##NETWORK - ID - REMOTE STATE
variable "vpc_id" {}
variable "sub_app_id" {}
variable "sub_app2_id" {}
variable "sub_database_id" {}
variable "sub_database2_id" {}

## NETWORK
variable "name_sub_rds" {}
variable "sub_app" {}
variable "sub_app2" {}
variable "sub_db" {}
variable "sub_db2" {}
variable "vpc" {}

## RDS
variable "db_engine" {}
variable "db_name" {}
variable "db_password" {}
variable "db_username" {}
variable "engine_version" {}
variable "instance_class" {}
variable "db_parameter" {}

## INSTANCE
variable "image" {}
variable "instance_type" {}
variable "key_name_ec2" {}
variable "env" {}
variable "project_name" {}
variable "tags" {}
#AUTOSCALING
variable "max_scaling" {}
variable "min_size" {}
variable "desired_capacity" {}
variable "health_check_grace_period" {}
variable "health_check_type" {}
##LOAD BALANCER
variable "lb_type" {}



