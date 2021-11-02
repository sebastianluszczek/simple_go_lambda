package main

import (
	"log"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

type Event struct {
	ShouldFail bool `json:shouldFail`
	Echo string `json:echo`
}

func Handler(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	log.Printf("Processing Lambda request %t\n", request.RequestContext)
	return events.APIGatewayProxyResponse{
		Body:       "Hello world",
		StatusCode: 200,
	}, nil
}

func main() {
	lambda.Start(Handler)
}