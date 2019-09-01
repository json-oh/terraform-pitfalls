variable "environment" {
  default = "dev"
}

variable "tags" {
  type    = map(string)
  default = {}
}
