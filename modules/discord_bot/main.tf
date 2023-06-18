provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "discord_bot" {
  metadata {
    name = "discord-bot"
  }
}

resource "kubernetes_deployment" "discord_bot" {
  metadata {
    name = "discord-bot-deployment"
    namespace = kubernetes_namespace.discord_bot.metadata[0].name

  }

  spec {
    replicas = var.discord_bot_replicas

    selector {
      match_labels = {
        app = "discord-bot"
      }
    }

    template {
      metadata {
        labels = {
          app = "discord-bot"
        }
      }
      
      spec {
        container {
          name  = "discord-bot"
          image = "${var.discord_bot_image_name}:${var.discord_bot_image_tag}"

          dynamic "env" {
            for_each = var.discord_bot_secrets
            content {
              name = env.key
              value_from {
                secret_key_ref {
                  name = kubernetes_secret.discord_bot.metadata[0].name
                  key  = env.key
                }
              }
            }
          }
        }
      }
    }
  }
}


resource "kubernetes_secret" "discord_bot" {
  metadata {
    name = "discord-bot-secrets"
    namespace = kubernetes_namespace.discord_bot.metadata[0].name
  }

    data = {
      for secret_name, secret_value in var.discord_bot_secrets : secret_name => secret_value
    }
}
