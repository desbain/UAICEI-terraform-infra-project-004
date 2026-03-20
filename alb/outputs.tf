output "jupiter_app_tg_arn" {
  value = [aws_lb_target_group.jupiter_app_tg.arn]
}

output "alb_dns_name" {
  value = aws_lb.jupiter_app_lb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.jupiter_app_lb.zone_id
}