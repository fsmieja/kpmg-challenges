data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}


resource "aws_iam_role" "webworker" {
  name = "web-worker-ec2"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}


resource "aws_iam_instance_profile" "webworker" {
  name = "webworker"
  role = aws_iam_role.webworker.name
}


resource "aws_iam_role" "appworker" {
  name = "app-worker-ec2"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}


resource "aws_iam_instance_profile" "appworker" {
  name = "appworker"
  role = aws_iam_role.appworker.name
}
