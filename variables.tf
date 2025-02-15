# Variables for flexibility
variable "rds_vpc_id" {
  description = "VPC ID for RDS"
  type        = string
}

variable "eks_vpc_cidr" {
  description = "CIDR block for EKS VPC"
  type        = string
  default     = "10.2.0.0/16"
}

variable "rds_subnet_ids" {
  description = "List of Subnet IDs for RDS subnet group"
  type        = list(string)
}