provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "aws_security_group" "sg_python_app" {
  name = "sg_${var.ecs_cluster_name}"
  description = "Allows all traffic"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  
  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }



}


resource "aws_iam_role" "host_role_python_app" {
  name = "host_role_${var.ecs_cluster_name}"
  assume_role_policy = "${file("policies/ecs-role.json")}"
}

resource "aws_iam_role_policy" "instance_role_policy_python_app" {
  name = "instance_role_policy_${var.ecs_cluster_name}"
  policy = "${file("policies/ecs-instance-role-policy.json")}"
  role = "${aws_iam_role.host_role_python_app.id}"
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "iam_instance_profile_${var.ecs_cluster_name}"
  path = "/"
  roles = ["${aws_iam_role.host_role_python_app.name}"]
}

resource "aws_ecs_cluster" "python_app" {
  name = "${var.ecs_cluster_name}"
}

resource "aws_launch_configuration" "lc_python_app" {
  name_prefix = "lc_${var.ecs_cluster_name}-"
  image_id = "ami-5be52c34"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.sg_python_app.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.iam_instance_profile.name}"
  key_name = "${var.key_name}"
  user_data = "${data.template_file.userdatatempl.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg_python_app" {
  name = "asg_${var.ecs_cluster_name}"
  availability_zones = ["${var.availability_zone}"]
  min_size = "${var.min_instance_size}"
  max_size = "${var.max_instance_size}"
  desired_capacity = "${var.desired_instance_capacity}"
  launch_configuration = "${aws_launch_configuration.lc_python_app.name}"


  tag {
    key = "Name"
    value = "${var.ecs_cluster_name}_asg"
    propagate_at_launch = true
  }
}


