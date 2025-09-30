provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Flask App Deployment
resource "kubernetes_deployment" "flask_app" {
  metadata {
    name = "flask-appp"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "flask-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "flask-app"
        }
      }

      spec {
        container {
          name  = "flask-app"
          image = "toyeebah/flask-app:latest"

          port {
            container_port = 5000
          }

          env {
            name  = "FLASK_ENV"
            value = "production"
          }
        }
      }
    }
  }
}

# Flask App Service
resource "kubernetes_service" "flask_app" {
  metadata {
    name = "flask-service"
  }

  spec {
    selector = {
      app = "flask-app"
    }

    port {
      protocol = "TCP"
      port     = 80
      target_port = 5000
    }

    type = "NodePort"
  }
}

# Prometheus ConfigMap
resource "kubernetes_config_map" "prometheus_config" {
  metadata {
    name = "prometheus-config"
  }

  data = {
    "prometheus.yml" = <<YAML
global:
  scrape_interval: 15s
scrape_configs:
  - job_name: 'flask-app'
    static_configs:
      - targets: ['flask-service:80']
YAML
  }
}

# Prometheus Deployment
resource "kubernetes_deployment" "prometheus" {
  metadata {
    name = "prometheus-deployment"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "prometheus"
      }
    }

    template {
      metadata {
        labels = {
          app = "prometheus"
        }
      }

      spec {
        container {
          name  = "prometheus"
          image = "prom/prometheus"

          args = ["--config.file=/etc/prometheus/prometheus.yml"]

          port {
            container_port = 9090
          }

          volume_mount {
            name       = "prometheus-config-volume"
            mount_path = "/etc/prometheus/"
          }
        }

        volume {
          name = "prometheus-config-volume"

          config_map {
            name = "prometheus-config"
          }
        }
      }
    }
  }
}

# Prometheus Service
resource "kubernetes_service" "prometheus_service" {
  metadata {
    name = "prometheus-service"
  }

  spec {
    selector = {
      app = "prometheus"
    }

    port {
      protocol = "TCP"
      port     = 9090
    }

    type = "NodePort"
  }
}

# Grafana Deployment
resource "kubernetes_deployment" "grafana" {
  metadata {
    name = "grafana-deployment"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "grafana"
      }
    }

    template {
      metadata {
        labels = {
          app = "grafana"
        }
      }

      spec {
        container {
          name  = "grafana"
          image = "grafana/grafana"

          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

# Grafana Service
resource "kubernetes_service" "grafana_service" {
  metadata {
    name = "grafana-service"
  }

  spec {
    selector = {
      app = "grafana"
    }

    port {
      protocol = "TCP"
      port     = 3000
    }

    type = "NodePort"
  }
}
