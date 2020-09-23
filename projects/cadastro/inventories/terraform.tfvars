aws_region = "us-east-1"
zone1 = "us-east-1a"
zone2 = "us-east-1b"

## BACKEND
//bucket_name = "backend-noemi"
//bucket_key = "terraform.tfstate"

##NETWORK - ID - REMOTE STATE
vpc_id = ""
sub_app_id = ""
sub_app2_id = ""
sub_database_id = ""
sub_database2_id = ""

##NETWORK
name_sub_rds = "rdssubnet"
sub_app = "10.0.1.0/24"
sub_app2 = "10.0.2.0/24"
sub_db = "10.0.3.0/24"
sub_db2 = "10.0.4.0/24"
vpc = "10.0.0.0/16"

## RDS
db_engine = "mysql"
db_name = "cadastro"
db_password = "********"
db_username = "root"
db_parameter = "default.mysql5.7"
engine_version = "5.7"
instance_class = "db.t2.micro"

## INSTANCE
image = "  "
instance_type = "t2.micro"
key_name_ec2 = "xxxxx"
#AUTOSCALING
max_scaling = 2
min_size = 2
desired_capacity = 2
health_check_grace_period = 30
health_check_type = "ELB"
##LOAD BALANCER
lb_type = "application"

## TAGS
tags = {
    ambiente = "dev"
    projeto = "cadastro"
    conta = "xxxxxx"
    plataforma = "aws"
}
project_name = "cadastro"
env = "dev"