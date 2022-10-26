package torque

test_allow_private_blob_storages {
  result:= deny with input as data.plan_mock.planned_values.root_module.resources[_].values.container_access_type
  count(result) == 0
}

test_allow_non_blob_storage_types {
  result:= deny with input as data.plan_mock.planned_values.root_module.resources[_].type.azurerm_storage_account
  count(result) == 1
}

test_deny_blob_storage_with_non_private_container_access_type {
  result:= deny with input as data.plan_mock.planned_values.root_module.resources[_].values.type
  count(result) == 0
}

test_validate_deny_message {
  result:= deny with input as data.plan_mock.planned_values.root_module.resources[_].values
  expected_deny_message:= "Deployment of not private blob storage is not allowed"
  result[expected_deny_message]
}

