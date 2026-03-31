
# 1.2.1. Pick a globally unique bucket name (something like xpix-photos-26w-yoursaultcollegeusername should work)

# 1.2.2. Set the ‘name’ tag to ‘xpix-photos’

resource "aws_s3_bucket" "the_s3_bucket"{
    bucket = "xpix-photos-26w-25014394saultcollege"
    tags = {
      "name" = "xpix-photos"
    }
}

# 1.3.1. Name: xpix-photos
# 1.3.2. Billing mode: PAY_PER_REQUEST
# 1.3.3. Hash key: photo_id
# 1.3.4. Stream enabled: true
# 1.3.5. Stream view type: NEW_IMAGE
# 1.3.6. Set the following String attributes: photo_id, user_id, uploaded_at, feed_key
# 1.3.7. Create two Global Secondary Indexes with a projection type of ‘ALL’:
    # 1.3.7.1. One named ‘user-photos-index' with ‘user_id’ as the hash key and ‘uploaded_at’ as the range key
    # 1.3.7.2. One named ‘feed-index’ with ‘feed_key’ as the hash key and ‘uploaded_at’ as the range key

resource "aws_dynamodb_table" "the_dynamo_table" {
  name = "xpix_photos"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "photo_id"
  stream_enabled = true
  stream_view_type = "NEW_IMAGE"
  attribute {
    name = "photo_id"
    type = "S" # "String" gives error. Must be S M or B
  }
  attribute {
    name = "user_id"
    type = "S"
  }
  attribute {
    name = "uploaded_at"
    type = "S"
  }
  attribute {
    name = "feed_key"
    type = "S"
  }

  global_secondary_index {
    projection_type = "ALL"
    name = "user-photos-index"
    # hash_key = attributes.photo_id
    key_schema {
      attribute_name = "user_id"
      key_type = "HASH"
    }
    key_schema {
      attribute_name = "uploaded_at"
      key_type = "RANGE"
    }
  }
  
  global_secondary_index {
    projection_type = "ALL"
    name = "feed-index"
    # hash_key = attributes.uploaded_at
    key_schema {
      attribute_name = "feed_key"
      key_type = "HASH"
    }
    key_schema {
      attribute_name = "uploaded_at"
      key_type = "RANGE"
    }
  }
}

# 1.4. Two String SSM Parameters:
    # 1.4.1. One named ‘/app/s3/photos_bucket_name’ with a reference to your S3 bucket (use the ‘bucket’ attribute) as the value
    # 1.4.2. One named '/app/dynamodb/photos_table_name’ with a reference to your DynamoDB table (use the ‘name’ attribute) as the value.

resource "aws_ssm_parameter" "storage_ssm_parameter1" {
    name = "/app/s3/photos_bucket_name"
    type = "String"
    value = aws_s3_bucket.the_s3_bucket.bucket
}

resource "aws_ssm_parameter" "storage_ssm_parameter2" {
    name = "/app/dynamodb/photos_table_name"
    type = "String"
    value = aws_dynamodb_table.the_dynamo_table.name
}