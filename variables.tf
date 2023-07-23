variable "flask_app_image" {
  default = "myregistry/flask_app:latest"
}

variable "lambda_function_name" {
  default = "my_lambda_function"
}

variable "rds_instance_name" {
  default = "my_rds_instance"
}

variable "rds_username" {
  default = "my_rds_username"
}

variable "rds_password" {
  default = "my_rds_password"
}