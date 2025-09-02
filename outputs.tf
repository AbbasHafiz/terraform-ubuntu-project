output "instance_ip" {
  value = module.ubuntu_ec2.instance_ip
}

output "ssh_command" {
  value = module.ubuntu_ec2.ssh_command
}
