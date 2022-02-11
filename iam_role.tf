data "template_file" "example" {
  template = "${file("s3-policy.json.tpl")}"
  }

resource "aws_iam_role_policy" "web_policy" {
  name = "web-policy"
  role = aws_iam_role.s3_role.id


  policy = data.template_file.example.rendered
}

resource "aws_iam_role" "s3_role" {
  name = "s3_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "s3_profile" {
  name  = "s3_profile"
  role = aws_iam_role.s3_role.name
}
