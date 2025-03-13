variable "min_size" {
  description = "Min quantity of VM"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Max quantity of VM"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "VM instance type"
  type        = string
  default     = "t2.micro"
}

variable "image_id" {
  description = "Image ID for VM"
  type        = string
  default     = "ami-06ee6255945a96aba"
}

variable "ssh_key_name" {
  description = "Existing ssh key for connecting to VM"
  type        = string
  default     = "ec2-tutorial"
}