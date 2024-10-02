resource "aws_vpc_peering_connection" "proj-peer" {
  count = var.is_peering_required ? 1:0
  peer_vpc_id   = aws_vpc.main.id
  vpc_id        = data.aws_vpc.default.id
  auto_accept = true

tags = merge(

  var.common_tags,
  var.vpc_peering_tags,
  {
    Name ="${local.resource_name}-default"
  }
)
        
}
resource "aws_route" "pub_peer" {
  count = var.is_peering_required ? 1:0
  route_table_id            = aws_route_table.public_rou_table.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.proj-peer[count.index].id
  
}
resource "aws_route" "pvt_peer" {
  count = var.is_peering_required ? 1:0
  route_table_id            = aws_route_table.pvt_rou_table.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.proj-peer[count.index].id
  
}


resource "aws_route" "default_peer" {
  count = var.is_peering_required ? 1:0
  route_table_id            = data.aws_vpc.vpc_info.main_route_table_id
  # route_table_id            = data.aws_route_table.main.route_table_id
  destination_cidr_block    = var.vpc_cidr
 vpc_peering_connection_id = aws_vpc_peering_connection.proj-peer[count.index].id
  /*data "aws_vpc" "vpc_info" { */
}









