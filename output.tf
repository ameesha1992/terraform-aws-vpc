output "vpc_id" {

    value = aws_vpc.main.id
  
}

output "az_info" {
    value = data.aws_availability_zones.sequence
}

output "default_vpc_info" {
value = data.aws_vpc.default


}

 output "vpc_info" {

    value = data.aws_vpc.vpc_info
   
 }
 output "pub_subnet_ids" {
    value = aws_subnet.public[*].id
   
 }
 output "private_subnet_ids" {
    value = aws_subnet.private[*].id
   
 }
 output "db_subnet_ids" {
    value = aws_subnet.db[*].id
   
 }
 output "db_group_subnet_ids" {
    value = aws_db_subnet_group.db_group.id
   
 }
 output "db_subnet_group_name" {
   value = aws_db_subnet_group.db_group.name
   
 }