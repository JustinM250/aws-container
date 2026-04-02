
terraform {
  required_version = "1.14.3"
  backend "s3" {
    bucket = "csd126-26w-25014394-terraform-state"
    key = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = true
    
  }
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

// 10:59 Running this has 2 import, 0,0,0

import {
  to = aws_cognito_user_pool.the_cognito_user_pool
  id = "us-east-1_uWfXDQ5gw"
}

import {
  to = aws_cognito_user_pool_client.the_cognito_user_pool_client
  id = "us-east-1_uWfXDQ5gw/6c7r5l0rk1jk70cvs4a657agdj"
}
