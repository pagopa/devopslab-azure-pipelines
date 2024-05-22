data "azuredevops_serviceendpoint_github" "github_rw" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = "azure-devops-github-rw"
}
