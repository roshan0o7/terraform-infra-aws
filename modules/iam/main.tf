resource "aws_iam_user" "clops_user" {
  name = "clops-user"
}

resource "aws_iam_user_policy" "clops_user_policy" {
  name = "clops-user-policy"
  user = aws_iam_user.clops_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action   = "s3:*",
      Effect   = "Allow",
      Resource = "*"
    }]
  })
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-private-bucket"
}
 resource "aws_s3_bucket_public_access_block" "my-private-bucket" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_iam_user_policy_attachment" "user_attach" {
  user       = aws_iam_user.clops_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
