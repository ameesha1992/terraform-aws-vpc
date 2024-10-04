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