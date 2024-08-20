# output "flask_app_service_node_port" {
#   value = kubernetes_service.flask_app.spec[0].node_port
# }

# output "prometheus_service_node_port" {
#   value = kubernetes_service.prometheus_service.spec[0].node_port
# }

# output "grafana_service_node_port" {
#   value = kubernetes_service.grafana_service.spec[0].node_port
# }

output "flask_app_service_node_port" {
  value = kubernetes_service.flask_app.spec[0].port[0].node_port
}

output "prometheus_service_node_port" {
  value = kubernetes_service.prometheus_service.spec[0].port[0].node_port
}

output "grafana_service_node_port" {
  value = kubernetes_service.grafana_service.spec[0].port[0].node_port
}
