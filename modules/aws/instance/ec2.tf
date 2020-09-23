resource "aws_security_group" "acesso" {
   name = "sgAcesso"
  vpc_id = var.vpc_id
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = "${merge(map("Name", "${var.env}-${var.project_name}-sgAcesso"), var.tags)}"
}
## INSTANCIA EC2 
resource "aws_instance" "app" {
  ami = var.image
  instance_type = var.instance_type
  key_name = var.key_name_ec2
  associate_public_ip_address = true
  availability_zone = var.zone1
  subnet_id = var.sub_app_id
  vpc_security_group_ids = [aws_security_group.acesso.id]
  tags = "${merge(map("Name", "${var.env}-${var.project_name}-appEC2"), var.tags)}"  
}

## AUTOSCALING
resource "aws_autoscaling_group" "scaling-ec2"{
  max_size = var.max_scaling
  min_size = var.min_size
  desired_capacity = var.desired_capacity
  health_check_grace_period = var.health_check_grace_period
  health_check_type = var.health_check_type
  vpc_zone_identifier = [var.sub_app_id, var.sub_app2_id]
  launch_configuration = aws_launch_configuration.launch-config-backend.name
}
resource "aws_launch_template" "scaling-temp"{
  name_prefix = "aplicacao"
  image_id = var.image
  instance_type = var.instance_type
}

resource "aws_launch_configuration" "launch-config-backend"{
  name_prefix = "launch-ec2-apps"
  image_id = var.image
  instance_type = var.instance_type
  security_groups =  [aws_security_group.acesso.id]
}

resource "aws_autoscaling_attachment" "asg-attachment"{
  autoscaling_group_name =  aws_autoscaling_group.scaling-ec2.id
  alb_target_group_arn = aws_lb_target_group.tg-aplicacao.arn
}

##LOAD BALANCER
resource "aws_lb" "lb-aplicacao"{
  internal = false
  load_balancer_type = var.lb_type
  security_groups = [aws_security_group.acesso.id]
  subnets = [var.sub_app_id, var.sub_app2_id]
  enable_deletion_protection = false
  tags = "${merge(map("Name", "${var.env}-${var.project_name}-LBapp"), var.tags)}"
}
resource "aws_lb_target_group" "tg-aplicacao"{
  port = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id = var.vpc_id
}
resource "aws_lb_listener" "app"{
  load_balancer_arn = aws_lb.lb-aplicacao.id
  port = 80
  default_action{
    target_group_arn = aws_lb_target_group.tg-aplicacao.id
    type = "forward"
  }
}






