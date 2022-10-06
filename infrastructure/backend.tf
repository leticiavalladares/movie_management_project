terraform {
    backend "s3" {
        bucket          = "ta-terraform-tfstates-439272626435"
        key             = "sprint1/week4/day4/training-terraform/terraform.tfstate"
        dynamodb_table  = "terraform-lock"
    }
}