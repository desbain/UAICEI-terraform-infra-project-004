#CREATING ALB SECURITY GROUP --------------------------------------------------------------------------
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP and HTTPs Traffic"
  vpc_id      = var.vpc_id

 tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-jupiter-server-sg"
  })
}



resource "aws_vpc_security_group_ingress_rule" "allow_http_for_dev_servers" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_for_dev_servers" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

#CREATING OUTBOUND RULE ALB -------------------------------------------------------
resource "aws_vpc_security_group_egress_rule" "allow_all_private_traffic_ipv4_using_sh" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

#CREATING TARGET GROUP----------------------------------------------------------------------
resource "aws_lb_target_group" "jupiter_app_tg" {
  name     = "jupiter-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
   
    health_check {
      healthy_threshold = 5
      interval = 30
      matcher = "200,301,302"
      path = "/"
      port = 80
      timeout = 5
      unhealthy_threshold = 2

    }
}

#CREATING APPLICATION LOAD BALANCER -----------------------------------------------------------------
resource "aws_lb" "jupiter_app_lb" {
  name               = "jupiter-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [var.public_subnet_az_2a_id, var.public_subnet_az_2b_id]

  enable_deletion_protection = false

 # access_logs {
   # bucket  = aws_s3_bucket.lb_logs.id
   # prefix  = "test-lb"
   # enabled = true
 # }

  tags = merge(var.tags, {
    Name = "${var.tags["project"]}-${var.tags["application"]}-${var.tags["environment"]}-jupiter-app-alb"
  })
}

#CREATING A LOAD BALANCER LISTENER ON PORT 80
resource "aws_lb_listener" "http_alb_listener" {
  load_balancer_arn = aws_lb.jupiter_app_lb.arn
  port              = "80"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "redirect"
    
    redirect {
      port = 443
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

#CREATING A LOAD BALANCER LISTENER ON PORT 443---------------------------------------------------------
resource "aws_lb_listener" "https_alb_listener" {
  load_balancer_arn = aws_lb.jupiter_app_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jupiter_app_tg.arn
        
  }
}

