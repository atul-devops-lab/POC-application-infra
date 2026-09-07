terraform {
  backend "s3" {
    bucket       = "atul-devops-lab-tfstate-595981035245-ap-south-1-an"
    key          = "eks/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
