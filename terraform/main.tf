module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.10.0"

  name = "supabase-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

<<<<<<< HEAD
#module "eks" {
#  source          = "terraform-aws-modules/eks/aws"
#  cluster_name    = "supabase-cluster"
#  cluster_version = "1.24"
#  subnets         = module.vpc.private_subnets
#  vpc_id          = module.vpc.vpc_id
#  manage_aws_auth = true
#}
=======
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0" # Or the latest supported version for your Terraform version
  cluster_name    = "supabase-cluster"
  cluster_version = "1.24"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  manage_aws_auth = true
>>>>>>> 6bbe5d88974377f45a817bb4de9b995727eb058d

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }
}
