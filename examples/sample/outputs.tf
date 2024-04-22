
output "tgw_id" {
  description = "Transit gateway ID"
  value       = module.tgw.tgw_id
}

output "vpn_conn_id" {
  description = "VPN connecction ID"
  value       = module.tgw.vpn_conn_id
}

output "cgw_id" {
  description = "Customer Gateway ID"
  value       = module.tgw.cgw_id
}
