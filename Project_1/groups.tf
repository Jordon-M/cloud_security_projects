
/* Creating IAM groups for different departments */

resource "aws_iam_group" "education" {
  name = "Education"
  path = "/groups/"
}

resource "aws_iam_group" "managers" {
  name = "Managers"
  path = "/groups/"
}

resource "aws_iam_group" "engineers" {
  name = "Engineers"
  path = "/groups/"
}

/* Adding users to groups based on their department */

resource "aws_iam_group_membership" "education_membership" {
  name = "education-membership"
  group = aws_iam_group.education.name
  users = [for user in aws_iam_user.users : user.name if user.tags.Department == "Education"]
}

resource "aws_iam_group_membership" "managers_membership" {
  name = "managers-membership"
  group = aws_iam_group.managers.name
  users = [
    for user in aws_iam_user.users : user.name if contains (keys(user.tags), "JobTitle") && can(regex("Manager|CEO", user.tags.JobTitle))
    ]
}

resource "aws_iam_group_membership" "engineers_membership" {
  name = "engineers-membership"
  group = aws_iam_group.engineers.name
  users = [for user in aws_iam_user.users : user.name if user.tags.Department == "Engineers"]
}
