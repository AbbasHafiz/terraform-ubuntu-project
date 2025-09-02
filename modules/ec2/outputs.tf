output "instance_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.ubuntu_vm.public_ip
}

output "ssh_command" {
  description = "SSH command to connect to the EC2 instance"
  value       = "ssh -i ${path.module}/terraform-key.pem ubuntu@${aws_instance.ubuntu_vm.public_ip}"
}
