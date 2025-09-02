# 🚀 Terraform AWS Ubuntu Project

This project deploys an **Ubuntu EC2 instance** on AWS using Terraform.  
It includes Terraform configuration files (`.tf`) and a helper script (`terraform_aws_script.sh`) to automate setup.

---

## 📂 Project Structure

terraform-aws-project/
├── main.tf # EC2 instance definition
├── variables.tf # Input variables
├── outputs.tf # Useful outputs (IP, etc.)
├── providers.tf # AWS provider setup
├── terraform_aws_script.sh # Helper script to deploy
└── README.md # Project documentation

yaml
Copy
Edit

---

## ⚙️ Prerequisites

Before using this project, make sure you have:

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed  
- [AWS CLI](https://aws.amazon.com/cli/) installed and configured:
  ```bash
  aws configure
Provide your:

AWS Access Key ID

AWS Secret Access Key

Default Region (e.g., us-east-1)

Output format (json)

🚀 Usage
Clone this repo

bash
Copy
Edit
git clone https://github.com/yourusername/terraform-aws-project.git
cd terraform-aws-project
Make script executable

bash
Copy
Edit
chmod +x terraform_aws_script.sh
Run the script

bash
Copy
Edit
./terraform_aws_script.sh
This will:

Initialize Terraform

Format & validate config

Create a plan

Apply and launch the EC2 instance

🔑 Accessing Your Instance
After deployment, Terraform will output the public IP of your EC2 instance.

If you used a key pair, connect via SSH:

bash
Copy
Edit
ssh -i terraform-key.pem ubuntu@<PUBLIC_IP>
🧹 Cleanup
To destroy all resources and avoid extra AWS costs:

bash
Copy
Edit
terraform destroy -auto-approve
📌 Notes
The default instance type is t2.micro (Free Tier eligible).

Modify variables.tf if you want to change region, AMI, or instance size.

Don’t forget to add .gitignore to avoid committing sensitive files:

markdown
Copy
Edit
*.tfstate
*.tfstate.backup
terraform-key.pem
.terraform/
