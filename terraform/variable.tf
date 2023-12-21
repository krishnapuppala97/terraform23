# vpc
variable "vpc_cidr_block" {
  description = "vpc cicdr range"
  type = string
  default = "10.0.0.0/16"
}

variable "tags" {
 description = "tags"
 type = map(string)
 default = {
   "name" = "demo",
   "env" = "dev"
 } 
}

#subnets
variable "public_subenets_cidr" {
  description = "public subnets"
  type = list(string)
  default = [ "10.0.2.0/24", "10.0.4.0/24", "10.0.6.0/24" ]  
}

variable "private_subenets_cidr" {
  description = "cidr range for private subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24" ]
}

variable "azs" {
  description = "availability zone's for subnets"
  type = list(string)
  default = ["us-east-1a","us-east-1b","us-east-1c"]
}