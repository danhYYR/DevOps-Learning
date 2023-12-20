data "azurerm_client_config" "current" {}

resource "azuread_application" "main" {
    display_name = var.sp-name
    owners = [data.azurerm_client_config.current.object_id]
}
resource "azuread_service_principal" "demo-sp" {
    client_id = azuread_application.main.client_id
    app_role_assignment_required = true
    owners = [data.azurerm_client_config.current.object_id]
}
resource "azuread_service_principal_password" "demo-sp-pass" {
  service_principal_id = azuread_service_principal.demo-sp.object_id
}
# Assign role for Vnet
resource "azurerm_role_assignment" "apiserver_subnet" {
    scope = var.CP_id
    principal_id = azuread_service_principal.demo-sp.object_id
    role_definition_name = "Network Contributor"
}
resource "azurerm_role_assignment" "cluster_subnet" {
    scope = var.Cluster_id
    principal_id = azuread_service_principal.demo-sp.object_id
    role_definition_name = "Network Contributor"
}