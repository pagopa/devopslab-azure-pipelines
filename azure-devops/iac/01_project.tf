data "azuredevops_project" "project" {
  name = local.project_name
}

resource "azuredevops_project_features" "project_features" {
  project_id = data.azuredevops_project.project.id
  features = {
    "boards"       = "disabled"
    "repositories" = "disabled"
    "pipelines"    = "enabled"
    "testplans"    = "disabled"
    "artifacts"    = "disabled"
  }
}
