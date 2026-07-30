
/* Creating IAM users from a CSV file using Terraform and breaking  
them into groups based on their department and job title
as well as grabbing the first letter of their first name 
and combining it with their last name to create a username */

resource "aws_iam_user" "users" {
  
for_each = {for user in local.users : user.first_name => user}

name = lower("${substr(each.value.first_name,0,1)}${each.value.last_name}")
path = "/users/"

  tags = {
    "DisplayName" = "${each.value.first_name} ${each.value.last_name}"
    "Department" = each.value.department
    "JobTitle" = each.value.job_title

  }
}


/* Creating IAM login profiles for the users and managing their credentials */

resource "aws_iam_user_login_profile" "user" {
  for_each = aws_iam_user.users

  user = each.value.name
  password_reset_required = true

  lifecycle {
    ignore_changes = [password_reset_required,password_length]
  }
}