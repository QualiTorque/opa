package torque.environment

import future.keywords.if

test_max_duration_denied if {
    print("Something good");

    value:= result 
                with input.duration_minutes as 350
                with data.max_duration_minutes as 300
                with data.duration_for_manual_minutes as 120

    print(value); 
    value.decision == "Denied"
    value.reason == "environment duration exceeds max duration in 5 hours"
}

# test_max_duration_denied_new_data_names {
#     test_result := result with input.duration_minutes as 350
#                           with data.env_max_duration_minutes as 300
#                           with data.env_duration_for_manual_approval_minutes as 120
#     test_result.decision == "Denied"
#     test_result.reason == "environment duration exceeds max duration in 5 hours"
# }

# test_max_duration_manual {
#     test_result := result 
#                           with input.duration_minutes as 120
#                           with data.max_duration_minutes as 200
#                           with data.duration_for_manual_minutes as 100
#     test_result.decision == "Manual"
#     test_result.reason == "environment duration requires approval"
# }

# test_max_duration_manual_new_data_names {
#     test_result := result 
#                           with input.duration_minutes as 120
#                           with data.env_max_duration_minutes as 200
#                           with data.env_duration_for_manual_approval_minutes as 100
#     test_result.decision == "Manual"
#     test_result.reason == "environment duration requires approval"
# }