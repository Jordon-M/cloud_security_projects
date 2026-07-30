
/* Showing the account ID of the AWS account being used */

data "aws_caller_identity" "name" {}

output "account_id" {
  value = data.aws_caller_identity.name
}