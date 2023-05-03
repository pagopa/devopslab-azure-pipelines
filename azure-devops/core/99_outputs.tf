output "service_connection_sonar_cloud_id" {
  value = azuredevops_serviceendpoint_sonarcloud.sonarcloud.id
}

output "service_connection_docker_registry_dev_name" {
  value = azuredevops_serviceendpoint_azurecr.azurecr_lab.service_endpoint_name
}

output "service_connection_docker_registry_dev_id" {
  value = azuredevops_serviceendpoint_azurecr.azurecr_lab.id
}
