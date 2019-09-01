variable "environment" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
