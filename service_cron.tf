resource "aws_ecs_task_definition" "crons" {
  family = "crons"
  container_definitions = "${file("task-definitions/crons.json")}"

}

resource "aws_ecs_service" "crons" {
  name = "crons"
  cluster = "${aws_ecs_cluster.python_app.id}"
  task_definition = "${aws_ecs_task_definition.crons.arn}"
  desired_count = "${var.desired_service_count}"
  depends_on = ["aws_autoscaling_group.asg_python_app"]
}
