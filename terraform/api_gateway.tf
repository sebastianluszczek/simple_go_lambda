resource "aws_apigatewayv2_api" "lambda_api" {
    name          = "v2-http-api"
    protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "lambda_stage" {
    api_id      = aws_apigatewayv2_api.lambda_api.id
    name        = "$default"
    auto_deploy = true
}

# getUsers
resource "aws_apigatewayv2_integration" "test" {
    api_id           = aws_apigatewayv2_api.lambda_api.id
    integration_type = "AWS_PROXY"

    integration_method   = "POST"
    integration_uri      = aws_lambda_function.lambda_func.invoke_arn
    passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "test" {
    api_id             = aws_apigatewayv2_api.lambda_api.id
    route_key          = "GET /"
    target             = "integrations/${aws_apigatewayv2_integration.test.id}"
}

resource "aws_lambda_permission" "test" {
    statement_id  = "AllowExecutionFromAPIGateway"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.lambda_func.arn
    principal     = "apigateway.amazonaws.com"

    source_arn = "${aws_apigatewayv2_api.lambda_api.execution_arn}/*/*"
}