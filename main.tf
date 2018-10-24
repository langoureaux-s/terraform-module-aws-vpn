provider "aws" {
  region = "${var.location}"
}

# Get vpc
data "aws_vpc" "vpc" {
  tags {
    Name = "${var.vpc_name}"
  }
}

# Get vpg
data "aws_vpn_gateway" "vpg" {
  attached_vpc_id = "${data.aws_vpc.vpc.id}"
}

# Get private subnet ids
data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.vpc.id}"
  tags {
    tier = "private"
  }
}

# Get private route table
data "aws_route_tables" "private_routes" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  filter {
    name   = "tag:Name"
    values = ["*-private"]
  }
}


# Create a customer gateway
resource "aws_customer_gateway" "vpn" {
  bgp_asn    = 65000
  ip_address = "${var.vpn_endpoint}"
  type       = "ipsec.1"

  tags       = "${var.tags}"
}

# Create a VPN gateway
module "vpn_gateway" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpn-gateway"

  vpc_id                  = "${data.aws_vpc.vpc.id}"
  vpn_gateway_id          = "${data.aws_vpn_gateway.vpg.id}"
  customer_gateway_id     = "${aws_customer_gateway.vpn.id}"


  # precalculated length of module variable vpc_subnet_route_table_ids
  vpc_subnet_route_table_count = "${length(data.aws_route_tables.private_routes.ids)}"
  vpc_subnet_route_table_ids   = "${data.aws_route_tables.private_routes.ids}"
  
  # Route type
  vpn_connection_static_routes_only = "${var.static_route}"

  # preshared keys (optional)
  tunnel1_preshared_key = "${var.vpn_tunnel1_key}"
  tunnel2_preshared_key = "${var.vpn_tunnel2_key}"
  tunnel1_inside_cidr   = "${var.custom_tunnel1_inside_cidr}"
  tunnel2_inside_cidr   = "${var.custom_tunnel2_inside_cidr}"
  
  tags       = "${var.tags}"
}