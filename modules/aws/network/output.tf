output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
output "sub_app_id" {
  value = aws_subnet.sub_app.id
}
output "sub_app2_id" {
  value = aws_subnet.sub_app2.id
}
output "sub_database_id" {
  value = aws_subnet.sub_db.id
}
output "sub_database2_id" {
  value = aws_subnet.sub_db2.id
}