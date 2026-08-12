variable "region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
  default     = "google-microservices-demo-cluster"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "How many AZs to use (public subnets only)."
  type        = number
  default     = 2
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version."
  type        = string
  default     = "1.34"
}

variable "node_instance_type" {
  description = "EC2 instance type for the managed node group."
  type        = string
  default     = "t3.large"
}

variable "node_disk_size_gb" {
  description = "Node group disk size in GiB."
  type        = number
  default     = 20
}

variable "node_min_size" {
  description = "Minimum number of nodes."
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of nodes."
  type        = number
  default     = 2
}

variable "node_desired_size" {
  description = "Desired number of nodes."
  type        = number
  default     = 1
}

