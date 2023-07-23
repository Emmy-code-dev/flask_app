output "flask_app_url" {
  value = module.flask_app.url
}

output "lambda_function_arn" {
  value = module.lambda_function.arn
}

output "rds_instance_address" {
  value = module.rds_instance.address
}