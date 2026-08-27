terraform {
  backend "s3" {
    bucket       = "atul-devops-lab-tfstate"
    key          = "eks/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
