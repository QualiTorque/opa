package torque

import input as tfplan

# --- Validate blob storage are private ---

deny[reason] {
    resources:= tfplan.resource_changes[_]
    resources.type == "azurerm_storage_blob"
    resources.change.after.container_access_type != "private"
    reason:= "Deployment of not private blob storage is not allowed"
}

