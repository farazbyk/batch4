variable my_amis {
type = map
  default = {
   "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-4b32be2b"
  }
}

variable instance_type {}
variable "sg" {
    type= list(string) 
}
variable subnet_id_module {}
variable key-name {}
variable custom_tags {
  type = map 
}