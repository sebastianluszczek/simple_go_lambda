package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

type Event struct {
	ShouldFail bool `json:shouldFail`
	Echo string `json:echo`
}

func Handler(ctx context.Context, event Event) (string, error) {
	if event.ShouldFail {
		return "", fmt.Errorf("Failed to handle %#v", event)
	}
	return event.Echo, nil
}

func main() {
	lambda.Start(Handler)
}