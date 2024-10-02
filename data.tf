data "aws_availability_zones" "sequence" {

    state = "available"
  
}

data "aws_vpc" "default" {

    default =true
  
}
data "aws_vpc" "vpc_info" {
    default = true

    
  
}