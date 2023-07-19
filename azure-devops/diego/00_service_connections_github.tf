data "azuredevops_serviceendpoint_github" "io-azure-devops-github-rw" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = "io-azure-devops-github-rw"
}
