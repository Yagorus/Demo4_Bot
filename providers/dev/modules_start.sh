#/bin/bash
terraform apply  -target=module.s3-init -auto-approve --var-file=./config/dev.tfvars plan.out
terraform apply  -target=module.ecr -auto-approve --var-file=./config/dev.tfvars plan.out
terraform apply  -target=module.init-build -auto-approve --var-file=./config/dev.tfvars plan.out
terraform apply  -target=module.ecs-cluster -auto-approve --var-file=./config/dev.tfvars plan.out
terraform apply  -target=module.s3 -auto-approve --var-file=./config/dev.tfvars plan.out