variable "nodes_instance_types" {
  description = "Instance type(s) to use for EKS"
  default     = ["t2.small"]
  type        = list(string)
}

variable "nodes_min_size" {
  description = "Minimum node count"
  default     = 1
  type        = number
}

variable "nodes_max_size" {
  description = "Maximum node count"
  default     = 10
  type        = number
}

variable "nodes_desired_size" {
  description = "Desired node count"
  default     = 2
  type        = number
}
