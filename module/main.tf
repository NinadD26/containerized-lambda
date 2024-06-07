# ECR repository
resource "aws_ecr_repository" "lambda-container-ecr" {
  name = "lambda-container-ecr"
  tags = {
  "project" : "blog-example"
  }
}

resource "null_resource" "ecr_image" {
  triggers = {
    python_file = md5(file("../app.py"))
    docker_file = md5(file("../Dockerfile"))
  }
}

data "aws_ecr_image" "lambda_image" {
  depends_on = [null_resource.ecr_image]
  repository_name = aws_ecr_repository.lambda-container-ecr.name
  image_tag       = var.image_tag
}


resource "aws_lambda_function" "lambda_docker_container" {
  depends_on = [
    null_resource.ecr_image
  ]
  function_name = "lambda_docker_container"
  architectures = ["x86_64"]
  role          = aws_iam_role.lambda.arn
  timeout       = 180
#   memory_size   = 10240
    memory_size = 3000
  image_uri     = "${aws_ecr_repository.lambda-container-ecr.repository_url}:latest"
  package_type  = var.package_type
  
}



resource "aws_iam_role" "lambda" {
  name = "example-lambda-role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
      "Action": "sts:AssumeRole",
      "Principal": {
         "Service": "lambda.amazonaws.com"
      },
       "Effect": "Allow"
   }
 ]
}
EOF
}
data "aws_iam_policy_document" "lambda" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    effect    = "Allow"
    resources = ["*"]
    sid       = "CreateCloudWatchLogs"
   }
}
resource "aws_iam_policy" "lambda" {
  name   = "example-lambda-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda.json
}