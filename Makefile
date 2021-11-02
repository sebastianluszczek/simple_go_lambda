build:
	GOOS=linux GOARCH=amd64  go build -o bin/app .

init:
	terraform init -backend-config=config/config.remote

plan:
	terraform plan

apply:
	terraform apply --auto-approve infra

destroy:
	terraform destroy --auto-approve infra