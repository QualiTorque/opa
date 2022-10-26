package torque

test_allow_vm_size {
  result:= deny 
                with input as data.plan_mock
                with data.prohibited_vm_size as ["DS1_v2", "D2ads_v5", "DS2_v2", "E2ads_v5", "E8bds_v5", "E4ds_v5"]
  count(result) == 0
}

test_deny_prohibited_vm_sizes {
  result:= deny 
                with input as data.plan_mock
                with data.prohibited_vm_sizes as ["DS1_v2","D2ads_v5", "DS2_v2", "E2ads_v5", "E8bds_v5", "E4ds_v5"]
  count(result) == 0
}

test_validate_deny_message {
  result:= deny 
                with input as data.plan_mock.planned_values.root_module.resources[_].values.vm_size
                with data.prohibited_vm_sizes as ["DS1_v2", "D2ads_v5", "DS2_v2", "E2ads_v5", "E8bds_v5", "E4ds_v5"]
  expected_deny_message:= "Invalid vm size: 'E8bds_v5'. The prohibited vm sizes are: [\"DS1_v2\", \"D2ads_v5\", \"DS2_v2\", \"E2ads_v5\", \"E8bds_v5\", \"E4ds_v5\" ]"
  result[expected_deny_message]
}
