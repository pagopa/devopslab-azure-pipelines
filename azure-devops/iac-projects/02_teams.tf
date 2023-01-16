resource "azuredevops_team" "external_team" {
  project_id = data.azuredevops_project.project.id
  name       = "${local.prefix}-iac-externals-team"
}
