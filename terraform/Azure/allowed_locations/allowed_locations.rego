package torque
import input as tfplan

deny[result] {
    allowed_locations_set:= {x | x:= data.allowed_locations[_]}
    locations:= {r | r := tfplan.planned_values.root_module.resources[_].values.location}
    diff:= allowed_locations_set - locations
    print("allowed_locations: ", allowed_locations_set)
    print("used_locations:    ", locations)
    print("diff: ", diff)
    result:= count(diff) > 0
    print("is_diff: ", result)
    
    # result:= concat("", ["Invalid location: '", locations, "'. The allowed locations are: ", sprintf("%s", [data.allowed_locations])])
}
