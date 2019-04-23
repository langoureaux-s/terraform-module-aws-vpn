variable "location" {
  description = "DC area"
}

variable "vpc_name" {
  description = "The VPC name"
}

variable "static_route" {
  description = "Use static route if true, else it use BGP"
  default = false
}

variable "vpn_endpoint" {
  description = "The customer VPN endpoint"
}

variable "vpn_tunnel1_key" {
  description = "The preshared key for the tunnel 1"
}

variable "vpn_tunnel2_key" {
  description = "The preshared key for the tunnel 2"
}

variable "vpn_tunnel1_inside_cidr" {
  description = "The CIDR block of the inside IP addresses for the first VPN tunnel"
  default = "169.254.33.88/30"
}

variable "vpn_tunnel2_inside_cidr" {
  description = "The CIDR block of the inside IP addresses for the second VPN tunnel"
  default = "169.254.33.100/30"
}

variable "customer_cidr_networks" {
  type = "list"
  description = "The CIDR customer network to route on"
}

variable "tags" {
  type = "map"
}