provider "aws" {
  region = "us-west-2"
}

module "flask_app" {
  source = "./modules/flask_app"
}

module "lambda_function" {
  source = "./modules/lambda_function"
}

module "rds_instance" {
  source = "./modules/rds_instance"
}