provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "exemplo" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.medium"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  tags = {
    Name = "instancia-exemplo"
  }
}

resource "aws_security_group" "instance" {
  name_prefix = "exemplo-instance"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "exemplo" {
  name               = "exemplo-lb"
  internal           = false
  load_balancer_type = "application"

  subnets          = ["${aws_subnet.exemplo.id}", "${aws_subnet.exemplo2.id}"]
  security_groups  = ["${aws_security_group.lb.id}"]
}

resource "aws_lb_listener" "exemplo" {
  load_balancer_arn = "${aws_lb.exemplo.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group" "exemplo" {
  name_prefix      = "exemplo-tg-"
  port             = "${var.port}"
  protocol         = "${var.protocol}"
  target_type      = "${var.target_type}"
}
