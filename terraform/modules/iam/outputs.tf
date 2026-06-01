output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster.arn
}

output "eks_nodes_role_arn" {
  value = aws_iam_role.eks_nodes.arn
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}

output "dev_view_access_key_id" {
  value     = aws_iam_access_key.dev_view.id
  sensitive = true
}

output "dev_view_secret_access_key" {
  value     = aws_iam_access_key.dev_view.secret
  sensitive = true
}

output "dev_view_password" {
  value     = aws_iam_user_login_profile.dev_view.password
  sensitive = true
}

output "alb_controller_policy_arn" {
  value = aws_iam_policy.alb_controller.arn
}
