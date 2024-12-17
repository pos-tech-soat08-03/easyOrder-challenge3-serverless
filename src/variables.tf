# data "aws_iam_role" "labrole" {
#   name = "LabRole"
# }

#variable "backendBucketVoclabs" {
#  description = "Bucket para armazenamento de arquivos de backend"
#}

# variable "accountIdVoclabs" {
#   description = "ID da conta AWS"
# }
# variable "accessConfig" {
#   default = "API_AND_CONFIG_MAP"
# }
# variable "clusterName" {
#   default = "easyorder"
# }
# variable "instanceType" {
#   default = "t3.medium"
# }
# variable "policyArn" {
#   default = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
# }


variable "bucket" {
  description = "The S3 bucket to store the Terraform state file"
  default     = "terraform-state-easyorder"
}
variable "key" {
  description = "The S3 key to store the Terraform state file"
  default     = "easyorder-infra/terraform.tfstate"
}
variable "region" {
  description = "The S3 region to store the Terraform state file"
  default     = "us-east-1"
}

variable "bucket_database" {
  description = "Bucket S3 para state do Terraform - Infra"
}

variable "key_database" {
  description = "Bucket S3 para state do Terraform - Infra"
}

data "terraform_remote_state" "easyorder-database" {
  backend = "s3"
  config = {
    bucket = var.bucket_database
    key    = var.key_database
    region = var.region
  }
}

variable "rds_host" {
  default = data.terraform_remote_state.easyorder-database.outputs.rds_host
}
variable "db_username" {}
variable "db_password" {}
variable "db_name" {}
