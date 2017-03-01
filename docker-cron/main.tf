
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}


resource "aws_ecr_repository" "crons" {
  name = "crons"
  provisioner "local-exec" {
    command = "./deploy-image.sh ${self.repository_url} ${var.cron_image_name}"
  }
}

variable "cron_image_name" {
  default = "crons"
  description = "Cron image name."
}

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
