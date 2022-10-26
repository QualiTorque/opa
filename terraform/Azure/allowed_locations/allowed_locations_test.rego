package torque

test_allowed_locations {
  result:= deny 
                with input as data.plan_mock
                with data.allowed_locations as ["eastus", "eastusXXX"]  
  
  result == {false}
}

test_deny_unsupported_location {
  result:= deny 
                with input as data.plan_mock
                # with data.allowed_locations as ["eastus", "eastusXXX"] 
                with data.allowed_locations as ["eastus1", "westus2"] 
  
  result == {true}
}

# test_validate_deny_message {
#   result:= deny 
#                 with input as data.plan_mock
#                 with data.allowed_locations as ["eastus2", "westus2"] 
#   expected_deny_message:= "Invalid location: '{\"eastusXXX\", \"eastus\"'. The allowed locations are: [\"eastus2\", \"westus2\"]"

#   result[expected_deny_message]
#   print(expected_deny_message)
# }
