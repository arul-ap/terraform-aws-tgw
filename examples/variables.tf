variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "default_tags" {
  description = "AWS account level tags inherit to all resources"
  type        = map(string)
  default = {
    Organization = "AsiaPac"
    Department   = "IT"
    CostCenter   = "IT"
  }
}
