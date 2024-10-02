variable "vpc_cidr" {

    default = "10.0.0.0/16"
  
}
variable "environment" {
    type = string
  
}
variable "enable_dns_hostname" {
    default = true
  
}
variable "common_tags" {
    default = {}
  
}
variable "project_name" {
 default = {}
  
}
variable "vpc_tags" {
default = {}
  
}
variable "pub_subnet_cidrs" {
type = list
validation {
             condition =length(var.pub_subnet_cidrs) == 2
  error_message = "provide 2 required cidrs"

}

}

variable "pvt_subnet_cidrs" {
type = list


validation {
             condition =length(var.pvt_subnet_cidrs) == 2
  error_message = "provide 2 required cidrs"

}

}

variable "db_subnet_cidrs" {
type = list
validation {
             condition =length(var.db_subnet_cidrs) == 2
  error_message = "provide 2 required cidrs"

}

}
variable "db_subnet_group_tags" {
    default = {}
  
}

variable "nat_tags" {
    default = {}
  
}
variable "aws_internet_gateway" {
    default = {}
  
}
variable "pub_rou_table_tags" {
    default = {}
  
}
variable "pvt_rou_table_tags" {
    default = {}
  
}
variable "db_rou_table_tags" {
    default = {}
  
}

variable "is_peering_required" {
    type = bool
    default = false
  
}
variable "vpc_peering_tags" {

    default = {}
  
}






































































































































































































    
  
