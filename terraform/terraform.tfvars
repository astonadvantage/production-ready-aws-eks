# WAS stack configuration

###############################################################################
# Required inputs
###############################################################################
account_id  = "292628133012"
aws_region  = "eu-west-1"
aws_profile = "default"
domain      = "hedingham.co"


###############################################################################
# Optional inputs
###############################################################################
shared_resource_name = "hedclstr"
aws_auth_users = [
  {
    userarn  = "arn:aws:sts::292628133012:assumed-role/AWSReservedSSO_AdministratorAccess_a6414d82df0d5ab2/Mitch"
    username = "Mitch"
    groups   = ["system:masters"]
  }
]

kms_key_owners = [
  "arn:aws:sts::292628133012:assumed-role/AWSReservedSSO_AdministratorAccess_a6414d82df0d5ab2/Mitch"
]
tags = {
  Terraform   = "true"
  Platform    = "Kube cluster"
  Environment = "hedclstr"
}

# AWS EKS Kubernetes
# -------------------------------------

cidr = "192.168.0.0/20"
private_subnets = [ "192.168.4.0/24",  "192.168.5.0/24" ]
public_subnets = [ "192.168.1.0/24", "192.168.2.0/24" ]

cluster_version = "1.29"