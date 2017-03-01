resource "aws_ecs_task_definition" "python_app" {
  family = "python"
  container_definitions = "${file("task-definitions/python_app.json")}"

}

resource "aws_ecs_service" "python_app" {
  name = "python_app"
  cluster = "${aws_ecs_cluster.python_app.id}"
  task_definition = "${aws_ecs_task_definition.python_app.arn}"
  desired_count = "${var.desired_service_count}"
  depends_on = ["aws_autoscaling_group.asg_python_app"]
}
