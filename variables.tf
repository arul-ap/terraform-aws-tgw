variable "org" {
  description = "Organization code to inlcude in resource names"
  type        = string
}
variable "proj" {
  description = "Project code to include in resource names"
  type        = string
}
variable "env" {
  description = "Environment code to include in resource names"
  type        = string
}

variable "tgw" {
  description = "Transit gateway details"
  type = object({
    name        = string
    description = string
    asn         = optional(number, 64512)
    tgw_cidr    = optional(list(string), [])
  })
}

variable "tgw_vpc_accepter" {
  description = "Acceptor for Transit gateway attachment request"
  type = map(object({
    tgw_attachment_id          = string
    tgw_default_rt_association = optional(bool, true)
    tgw_deafult_rt_propagation = optional(bool, true)
  }))
  default = {}
}

variable "vpn" {
  description = "VPN attachement for Transit gateway"
  type = map(object({
    asn        = number
    ip_address = string
    no_bgp = optional(bool,false)
  }))
  default = {}
}
variable "tgw_share_principal_list" {
  description = "Share transit gateway across accounts using AWS Resource Access Manager"
  type        = list(string) // list of Account ID, Org ARN or OU ARN.
  default     = []
}
