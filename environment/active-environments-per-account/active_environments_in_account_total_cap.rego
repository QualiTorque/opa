package torque.environment

default result = {
  "decision": "Approved",
  "reason": "Within account-wide active environments cap"
}

is_launch {
  lower(input.action_identifier.action_type) == "launch"
}

valid_cap {
  to_number(data.max_active_environments_in_account[0])
}

result = {
  "decision": "Denied",
  "reason": "Policy variable max_active_environments_in_account is missing or invalid"
} {
  is_launch
  not valid_cap
}

result = {
  "decision": "Denied",
  "reason": sprintf(
    "Account-wide active environments cap exceeded: active=%v cap=%v",
    [input.active_environments_in_account, to_number(data.max_active_environments_in_account[0])]
  )
} {
  is_launch
  valid_cap
  input.active_environments_in_account >= to_number(data.max_active_environments_in_account[0])
}