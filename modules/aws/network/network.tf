resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc
  tags = "${merge(map("Name", "${var.env}-${var.project_name}-VPC-Noemi"), var.tags)}"

}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
}
resource "aws_route_table" "route_vpc" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
################################################
#SUBNET APP

resource "aws_subnet" "sub_app" {
  cidr_block = var.sub_app
  vpc_id = aws_vpc.my_vpc.id
  availability_zone = var.zone1
  tags = "${merge(map("Name", "${var.env}-${var.project_name}-Sub-app"), var.tags)}"
}
resource "aws_route_table_association" "app-route" {
  route_table_id = aws_route_table.route_vpc.id
  subnet_id = aws_subnet.sub_app.id
}

resource "aws_subnet" "sub_app2" {
  cidr_block = var.sub_app2
  vpc_id = aws_vpc.my_vpc.id
  availability_zone = var.zone2
  tags = "${merge(map("Name", "${var.env}-${var.project_name}-Sub-app2"), var.tags)}"
}
resource "aws_route_table_association" "app2-route" {
  route_table_id = aws_route_table.route_vpc.id
  subnet_id = aws_subnet.sub_app2.id
}

#SUBNET DATABASE
resource "aws_subnet" "sub_db" {
  cidr_block = var.sub_db
  vpc_id = aws_vpc.my_vpc.id
  availability_zone = var.zone1
  tags = "${merge(map("Name", "${var.env}-${var.project_name}-Sub-DB"), var.tags)}"
}

resource "aws_subnet" "sub_db2" {
  cidr_block = var.sub_db2
  vpc_id = aws_vpc.my_vpc.id
   availability_zone = var.zone2
   tags = "${merge(map("Name", "${var.env}-${var.project_name}-Sub-DB2"), var.tags)}"
}

