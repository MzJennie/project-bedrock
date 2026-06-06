variable "project_name" {
  type = string
}

variable "cluster_name" {
  type    = string
  default = "project-bedrock-cluster"
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "eks_cluster_role_arn" {
  type = string
}

variable "eks_nodes_role_arn" {
  type = string
}

variable "eks_nodes_sg_id" {
  type = string
}

variable "node_instance_type" {
  type    = string
  default = "t3.small"
}

variable "node_desired_size" {
  type    = number
  default = 2
}

variable "node_min_size" {
  type    = number
  default = 1
}

variable "node_max_size" {
  type    = number
  default = 3
}

variable "tags" {
  type    = map(string)
  default = {}
}
