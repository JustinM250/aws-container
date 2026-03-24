
terraform {
  required_version = "1.14.3"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}



// Cognito stuff.

# // User pool.
# import {
#   to = 
#   id = "us-east-1_uWfXDQ5gw"
# }

# // Client 1
# import {
#   to = 
#   id = "6c7r5l0rk1jk70cvs4a657agdj"
# }