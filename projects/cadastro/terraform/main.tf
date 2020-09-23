provider "aws" {
  profile = "default"
  shared_credentials_file = "/.aws/credentials"
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "backend"
    key = "terraform.tfstate"
    region = "us-east-1"   
  }
}

module "backend-s3" {
  source = "../../../modules/aws/backend"
  aws_region = var.aws_region
  bucket_key = var.bucket_key
  bucket_name = var.bucket_name
}
module "database-rds" {
  source = "../../../modules/aws/database"
  db_engine = var.db_engine
  db_name = var.db_name
  db_password = var.db_password
  db_username = var.db_username
  db_parameter = var.db_parameter
  engine_version = var.engine_version
  instance_class = var.instance_class
  name_sub_rds = var.name_sub_rds
  vpc_id = data.terraform_remote_state.tf-remote.outputs.vpc_id
  sub_database2_id = data.terraform_remote_state.tf-remote.outputs.sub_database2_id
  sub_database_id = data.terraform_remote_state.tf-remote.outputs.sub_database_id
  project_name = var.project_name
  env = var.env
  tags = var.tags
}
module "instance-ec2" {
  source = "../../../modules/aws/instance"
  sub_app2_id = data.terraform_remote_state.tf-remote.outputs.sub_app2_id
  sub_app_id = data.terraform_remote_state.tf-remote.outputs.sub_app_id
  vpc_id = data.terraform_remote_state.tf-remote.outputs.vpc_id
  image = var.image
  instance_type = var.instance_type
  key_name_ec2 = var.key_name_ec2
  zone1 = var.zone1
  zone2 = var.zone2
  max_scaling = var.max_scaling
  min_size = var.min_size
  desired_capacity = var.desired_capacity
  health_check_grace_period = var.health_check_grace_period
  health_check_type = var.health_check_type
  lb_type = var.lb_type
  project_name = var.project_name
  env = var.env
  tags = var.tags
}
module "network" {
  source = "../../../modules/aws/network"

  sub_app = var.sub_app
  sub_app2 = var.sub_app2
  sub_db = var.sub_db
  sub_db2 = var.sub_db2
  vpc = var.vpc
  zone1 = var.zone1
  zone2 = var.zone2
  project_name = var.project_name
  env = var.env
  tags = var.tags
}


data "terraform_remote_state" "tf-remote" {
  backend = "s3"
config = {
  bucket = "backend"
  key = "terraform.tfstate"
  region = "us-east-1"
  }
}

output "vpc_id" {
  value = module.network.vpc_id
}
output "sub_app_id"{
  value = module.network.sub_app_id
}
output "sub_app2_id" {
  value = module.network.sub_app2_id
}
output "sub_database_id" {
  value = module.network.sub_database_id
}
output "sub_database2_id" {
  value = module.network.sub_database2_id
}

