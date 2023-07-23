resource "aws_ecs_task_definition" "flask_app" {
  family                   = "flask-app"
  container_definitions    = jsonencode([{
    name      = "flask-app"
    image     = var.flask_app_image
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])

  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
}

resource "aws_ecs_service" "flask_app" {
  name                       = "flask-app-service"
  cluster_arn                = aws_ecs_cluster.default.arn
  task_definition            = aws_ecs_task_definition.flask_app.arn
  desired_count              = 1
  launch_type                = "FARGATE"
  platform_version           = "LATEST"

  load_balancer {
    target_group_arn = aws_lb_target_group.flask_app.arn
    container_name   = "flask-app"
    container_port   = 80
  }
}

resource "aws_lb_target_group" "flask_app" {
  name        = "flask-app-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_lb_listener_rule" "flask_app" {
  priority = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.flask_app.arn
  }

  condition {
    host_header {
      values = ["${aws_route53_record.flask_app