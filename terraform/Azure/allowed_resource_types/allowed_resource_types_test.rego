package torque

test_allowed_resource_types {
  result:= deny 
                with input as data.plan_mock
                with data.allowed_resource_types as ["azurerm_resource_group", "azurerm_storage_account", "azurerm_storage_container"] 
                # with data.allowed_resource_types as ["azurerm_resource_group"] # uncomment this line to fail the test
  count(result) == 0
}

test_deny_unsupported_resource_types {
  result:= deny 
                with input as data.plan_mock
                with data.allowed_resource_types as ["azure_vm", "azure_date_lake_storage"] 
                # with data.allowed_resource_types as ["azurerm_resource_group", "azurerm_storage_account", "azurerm_storage_container"] # uncomment this line to fail the test
  count(result) == 1
}

test_validate_deny_message {
  result:= deny 
                with input as data.plan_mock
                with data.allowed_resource_types as ["azure_vm", "azure_date_lake_storage"] 
  expected_deny_message:= "Invalid resource type: '{\"azurerm_resource_group\", \"azurerm_storage_account\", \"azurerm_storage_container\"}'. The allowed resource types are: {\"azure_date_lake_storage\", \"azure_vm\"}"
  result[expected_deny_message]
}
