resource "aws_vpc" "main" {


  cidr_block       = var.vpc_cidr
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    name = "main"
  }
}
resource "aws_subnet" "public" {
  count = length(var.pub_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.pub_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true
tags = merge(

var.common_tags,
var.vpc_tags,
{
   Name = "${local.resource_name}-public-${local.az_names[count.index]}"
}
 

)
}

resource "aws_subnet" "private" {
  count = length(var.pvt_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.pvt_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  
tags = merge(

var.common_tags,
var.vpc_tags,
{
   Name = "${local.resource_name}-private-${local.az_names[count.index]}"
}
 

)
}
#db group creation for rds
resource "aws_subnet" "db" {
  count = length(var.db_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.db_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  
tags = merge(

var.common_tags,
var.vpc_tags,
{
   Name = "${local.resource_name}-db-${local.az_names[count.index]}"
}
 

)
}
resource "aws_db_subnet_group" "db_group" {
  name =local.resource_name
  subnet_ids =aws_subnet.db[*].id 
  
  tags = merge (

  var.common_tags,
  var.db_subnet_group_tags,
{
   Name = local.resource_name
}
  )
}
resource "aws_eip" "elastic" {
  domain = "vpc"

}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.elastic.id
subnet_id =aws_subnet.public[0].id
tags = merge(

var.common_tags,
var.nat_tags,
{
   Name = local.resource_name
}
)
depends_on = [aws_internet_gateway.gw]
} 
resource "aws_route_table" "public_rou_table" {
  vpc_id = aws_vpc.main.id
tags = merge(
     var.common_tags,
     var.pub_rou_table_tags,
     {
      Name ="${local.resource_name}-public"
     }

)

}
resource "aws_route_table" "pvt_rou_table" {
  vpc_id = aws_vpc.main.id
tags = merge(
     var.common_tags,
     var.pvt_rou_table_tags,
     {
      Name ="${local.resource_name}-private"
     }

)
    
  }

resource "aws_route_table" "db_rou_table" {
  vpc_id = aws_vpc.main.id
tags = merge(
     var.common_tags,
     var.db_rou_table_tags,
     {
      Name ="${local.resource_name}-database"
     }

)

}
resource "aws_route" "pub_route" {
  route_table_id            = aws_route_table.public_rou_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
  
}
resource "aws_route" "pvt_route" {
  route_table_id            = aws_route_table.pvt_rou_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.nat.id
}

resource "aws_route" "db_route" {
  route_table_id            = aws_route_table.db_rou_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id =aws_nat_gateway.nat.id
}


