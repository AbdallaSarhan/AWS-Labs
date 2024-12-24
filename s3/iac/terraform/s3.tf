resource "aws_s3_bucket" "my-s3-bucket" {
#   bucket = "my-tf-test-bucket" - commented out to get a random bucket name
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}