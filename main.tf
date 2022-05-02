resource "aws_instance" "ec2" {
  ami           = "${var.ami}"
  instance_type = "${var.ec2_class}"
  key_name  = "${var.key_pair}"
  subnet_id = "${var.subnet_1a}"
  vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]

  tags = {
    Name = "${var.product}.${var.environment}-ec2"
  }
}
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.product}.${var.environment}-ec2-profile"
  role = "${aws_iam_role.ec2_role.name}"
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.product}.${var.environment}-ec2-role-new"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_security_group" "ec2-sg" {
  name        = "${var.product}.${var.environment}-ec2-sg"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}
