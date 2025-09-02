#!/bin/bash
# =========================================
# terraform_aws_script.sh
# Automates Terraform AWS deployment for Ubuntu EC2
# =========================================

set -e   # Exit on error

# 1️⃣ Go to project directory (assumes this script is in project root)
PROJECT_DIR=$(dirname "$0")
cd "$PROJECT_DIR" || { echo "Project directory not found!"; exit 1; }

# 2️⃣ Check Terraform installation
if ! command -v terraform &> /dev/null; then
    echo "[ERROR] Terraform is not installed. Install it first."
    exit 1
fi

# 3️⃣ Check AWS CLI installation
if ! command -v aws &> /dev/null; then
    echo "[ERROR] AWS CLI is not installed. Install it first."
    exit 1
fi

# 4️⃣ Make sure AWS is configured
if ! aws sts get-caller-identity &> /dev/null; then
    echo "[ERROR] AWS CLI is not configured. Run 'aws configure'."
    exit 1
fi

# 5️⃣ Create .gitignore if missing
if [ ! -f .gitignore ]; then
    cat <<EOL > .gitignore
# Terraform
*.tfstate
*.tfstate.backup
.terraform/
terraform-key.pem
*.log
EOL
    echo "[INFO] .gitignore created."
fi

# 6️⃣ Create terraform.tfvars if missing
if [ ! -f terraform.tfvars ]; then
    cat <<EOL > terraform.tfvars
region = "us-east-1"
instance_type = "t2.micro"
key_name = "my-personal-key"
EOL
    echo "[INFO] terraform.tfvars created with default values."
fi

# 7️⃣ Initialize Terraform
echo "🔹 Initializing Terraform..."
terraform init

# 8️⃣ Format Terraform files
echo "🔹 Formatting Terraform files..."
terraform fmt

# 9️⃣ Validate Terraform configuration
echo "🔹 Validating Terraform config..."
terraform validate

# 10️⃣ Plan Terraform deployment
echo "🔹 Planning infrastructure..."
terraform plan -out=tfplan

# 11️⃣ Apply Terraform deployment
echo "🔹 Applying infrastructure..."
terraform apply -auto-approve tfplan

# 12️⃣ Display outputs
echo
echo "✅ Deployment complete! Here are the outputs:"
terraform output

echo
echo "🔑 To connect to your Ubuntu EC2 instance:"
echo "ssh -i terraform-key.pem ubuntu@$(terraform output -raw public_ip)"

echo
echo "🧹 To destroy all resources when done:"
echo "terraform destroy -auto-approve"
