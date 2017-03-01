variable "access_key" {
  description = "The AWS access key."
}

variable "secret_key" {
  description = "The AWS secret key."
}

variable "region" {
  description = "The AWS region to create resources in."
  default = "eu-central-1"
}

variable "availability_zone" {
  description = "The availability zone"
  default = "eu-central-1a"
}

variable "vpc_id" {
  description = "The availability zone"
  default = "vpc-445b232d"
}

variable "ecs_cluster_name" {
  description = "The name of the Amazon ECS cluster."
  default = "python_app"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "puppet_fg"
  description = "SSH key name in your AWS account for AWS instances."
}

variable "min_instance_size" {
  default = 1
  description = "Minimum number of EC2 instances."
}

variable "max_instance_size" {
  default = 2
  description = "Maximum number of EC2 instances."
}

variable "desired_instance_capacity" {
  default = 1
  description = "Desired number of EC2 instances."
}

variable "desired_service_count" {
  default = 1
  description = "Desired number of ECS services."
}

variable "python_app_repository_url" {
  default = "python_app"
  description = "ECR Repository for Jenkins."
}
