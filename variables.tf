variable "rds_vpc_id" {
  description = "(Required) VPC ID for RDS"
  type        = string
}

variable "eks_vpc_cidr" {
  description = "(Optional) CIDR block for EKS VPC"
  type        = string
  default     = "10.2.0.0/16"
}

variable "rds_subnet_ids" {
  description = "(Required) List of Subnet IDs for RDS subnet group"
  type        = list(string)
}

variable "app_role_name" {
  description = "(Required) name of the application role that will be accessing the database"
  type        = string
}
