output "sp-object_id" {
  description = "The object_id of the service principal. Can used to assign role for user"
  value = data.azuread_service_principal.pipeline-sp.object_id
}
output "tennet_id" {
  value = data.azuread_service_principal.pipeline-sp.application_tenant_id
}
output "application_id" {
  value = data.azuread_service_principal.pipeline-sp.application_id
}

output "client_id" {
  value = azuread_application.main.client_id
}
output "client_secret" {
  value = azuread_service_principal_password.demo-sp-pass.value
}