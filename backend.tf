terraform {
    backend "s3" {
        bucket = "terraform-state-file-batch4"
        key = "vpc/terraform.state"
        region = "us-east-1"
        encrypt = true
        dynamodb_table = "batch4"
    }
}
