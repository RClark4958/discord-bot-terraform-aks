output "deployment_name" {
  description = "The name of the deployment"
  value       = kubernetes_deployment.discord_bot.metadata[0].name
}