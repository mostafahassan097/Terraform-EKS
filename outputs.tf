output "vpc_id"{
  value =  module.vpc.vpc_id
}

output "public_subnet_ids"{
  value =  module.vpc.public_subnet_ids
}

output "private_subnet_ids"{
  value =  module.vpc.private_subnet_ids
}
output "bastion_public_ip" {
  description = "Public IP address of the bastion instance"
  value       = module.bastion.bastion_public_ip
}
