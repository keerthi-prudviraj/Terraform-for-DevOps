variable "env" {
    description = "This is the Environment variable"
    type        = string
}

variable "bucket_name" {
    description = "This is the bucket name variable"
    type        = string
}

variable "instance_count" {
    description = "This is the instance count variable"
    type        = number
}

variable "instance_type" {
    description = "This is the instance type variable"
    type        = string
}

variable "ami_id" {
    description = "This is the AMI ID variable"
    type        = string
}
variable "hash_key" {
    description = "This is the hash key variable"
    type        = string
}