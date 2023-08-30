package torque.environment

import future.keywords.if

# The purpose of this policy is to enforce a maximum number of active environments in account per owner.
# It takes the following number as an argument (in the data object):
#   max_active_envs_in_account_per_owner
#
# An example of a data object for this policy looks like this:
# {
#   "max_active_envs_in_account_per_owner": 5,
# }
#
# In this example we set the maximum number of active environments in account for a given owner to be 5. 
result := {"decision": "Denied", "reason": "max_active_envs_in_account_per_owner must be a number"} if {
	data.max_active_envs_in_account_per_owner
	not is_number(data.max_active_envs_in_account_per_owner)
}

result = {"decision": "Denied", "reason": "Owner has reached the maximum number of active environments allowed in account"} if {
    is_number(data.max_active_envs_in_account_per_owner)
	data.max_active_envs_in_account_per_owner < input.owner_active_environments_in_account + 1
}

result = {"decision": "Approved"} if {
    is_number(data.max_active_envs_in_space_per_owner)
	data.max_active_envs_in_space_per_owner >= input.owner_active_environments_in_account + 1
}