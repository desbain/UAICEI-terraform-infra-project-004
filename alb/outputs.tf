output "jupiter_app_tg_arn" {
  value = [aws_lb_target_group.jupiter_app_tg.arn]
}