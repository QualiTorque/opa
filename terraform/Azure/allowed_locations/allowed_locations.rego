package torque

import input as tfplan

# --- Validate location ---

get_location(provider_name) = location {
    location:= trim_prefix(input.planned_values.root_module.resources[_].values.location, "var.")
}

get_basename(path) = basename{
    arr:= split(path, "/")
    basename:= arr[count(arr)-1]
}

contains(arr, elem){
    arr[_] == elem
}

deny[reason] {
    provider_name:= get_basename(tfplan.resource_changes[_].provider_name) 
    location:= get_location(provider_name)
    not contains(data.allowed_locations, location)
    reason:= concat("",["Invalid location: '", location, "'. The allowed locations are: ", sprintf("%s", [data.allowed_locations])])
}
