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

variable "tags" {
  type = "map"
}