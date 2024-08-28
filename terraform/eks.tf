module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.24"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t3.medium"

      key_name = "your-ssh-key"  # Replace with your SSH key name
    }
  }
  
  manage_aws_auth = true
  enable_irsa     = true
}

output "kubeconfig" {
  description = "Kubeconfig to connect to the EKS cluster"
  value       = module.eks.kubeconfig
  sensitive   = true
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

