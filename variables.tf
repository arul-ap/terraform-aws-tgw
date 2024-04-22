variable "org" {
  description = "Organization code to inlcude in resource names"
  type = string
}
variable "proj" {
  description = "Project code to include in resource names"
  type = string
}
variable "env" {
  description = "Environment code to include in resource names"
  type = string
}

variable "tgw" {
  type = object({
    name = string
    description = string
    asn = optional(number,64512)
    tgw_cidr = optional(list(string),[])
  })
}

variable "tgw_vpc_accepter" {
  type = map(object({
    tgw_attachment_id = string
    tgw_default_rt_association = optional(bool,true)
    tgw_deafult_rt_propagation = optional(bool,true)
  }))
  default = {}
}

variable "vpn" {
  type = map(object({
    asn = number
    ip_address = string
  }))
  default = {}
}
variable "tgw_share_principal_list" {
  type = list(string) // list of Account ID, Org ARN or OU ARN.
  default = []
}
