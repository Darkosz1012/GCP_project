output "deployment_invoke_url" {
  description = "Deployment invoke url"
  value       = google_api_gateway_gateway.gw.default_hostname
}
