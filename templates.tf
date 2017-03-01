data "template_file" "userdatatempl" {

  template = "${file("userdata.sh")}"

  vars {
    ecs_cluster_name    = "${var.ecs_cluster_name}"
  }
}
