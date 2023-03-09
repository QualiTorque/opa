package torque.environment

import future.keywords.if

test_max_duration_denied_input_greater_than_max {
    value := result with input.duration_minutes as 350
                          with data.env_max_duration_minutes as 300
                          with data.env_duration_for_manual_approval_minutes as 120
    value.decision == "Denied"
    value.reason == "environment duration exceeds max duration of 5 hours"
}

test_max_duration_manual_max_duration_manual_less_than_input {
    value := result 
                          with input.duration_minutes as 120
                          with data.env_max_duration_minutes as 200
                          with data.env_duration_for_manual_approval_minutes as 100
    value.decision == "Manual"
    value.reason == "environment duration requires approval"
}

test_max_duration_approved_equal_values {
    value := result 
                          with input.duration_minutes as 120
                          with data.env_max_duration_minutes as 300
                          with data.env_duration_for_manual_approval_minutes as 300
    value.decision == "Approved"
}

test_max_duration_approved_input_less_than_both_manual_less_than_max {
    value := result 
                          with input.duration_minutes as 120
                          with data.env_max_duration_minutes as 200
                          with data.env_duration_for_manual_approval_minutes as 150
    value.decision == "Approved"
}

test_max_duration_approved_max_duration_less_than_manual {
    value := result 
                          with input.duration_minutes as 120
                          with data.env_max_duration_minutes as 290
                          with data.env_duration_for_manual_approval_minutes as 300
    value.decision == "Approved"
}

test_max_duration_denied_input_less_than_manual_but_greater_than_max {
    value := result 
                          with input.duration_minutes as 295
                          with data.env_max_duration_minutes as 290
                          with data.env_duration_for_manual_approval_minutes as 300
    value.decision == "Denied"
    value.reason == "environment duration exceeds max duration of 4 hours 50 minutes"
}