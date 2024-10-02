locals {
  
 resource_name = "${var.project_name}-${var.environment}"
}
locals {
   az_names= slice(data.aws_availability_zones.sequence.names,0,2)

}
