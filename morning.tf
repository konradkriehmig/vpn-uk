$env:ARM_SUBSCRIPTION_ID="8d9e4373-f610-460e-8c58-e1dc091ba829"
cd bootstrap
terraform apply -target=azurerm_role_assignment.tfstate_blob -auto-approve
terraform apply -auto-approve
cd ../infra
terraform init