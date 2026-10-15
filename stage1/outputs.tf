output "AZURE_CLIENT_ID" {
  value = azurerm_user_assigned_identity.this.client_id
}

output "AZURE_TENANT_ID" {
  value = data.azurerm_client_config.current.tenant_id
}

output "AZURE_SUBSCRIPTION_ID" {
  value = var.subscription_id
}

output "federated_subject" {
  value = azurerm_federated_identity_credential.github.subject
}
