provider "aws" {
  region = "eu-central-1"
}

variable "app_name" {
  description = "Application name"
  default     = "lambda_example"
}

variable "app_env" {
  description = "Application environment tag"
  default     = "dev"
}


data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../bin/app"
  output_path = "../bin/app.zip"
}