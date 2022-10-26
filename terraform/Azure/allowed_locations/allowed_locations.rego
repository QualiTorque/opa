package torque
import input as tfplan

deny[reason] {
    allowed_locations_set:= {x | x:= data.allowed_locations[_]}
    locations:=  { r | r := tfplan.planned_values.root_module.resources[_].values.location }
    diff:= locations - allowed_locations_set
    
    # print("allowed_locations: ", allowed_locations_set)
    # print("used_locations:    ", locations)
    # print("diff: ", diff)

    count(diff) > 0 # if true -> deny! and return this error ("reason") below
    reason:= concat("",["Invalid region: '", sprintf("%s", [locations]),"'. The allowed regions are: ", sprintf("%s", [allowed_locations_set])])
}