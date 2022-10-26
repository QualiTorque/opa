package torque
import input as tfplan

deny[reason] {
    allowed_set:= { x | x:= data.allowed_locations[_] }
    results_set:= { r | r := tfplan.resource_changes[_].change.after.location }
    diff:= results_set - allowed_set
    
    # print("allowed_set:       ", allowed_set)
    # print("used_locations:    ", results_set)
    # print("diff:              ", diff)

    count(diff) > 0 # if true -> deny! and return this error ("reason") below
    reason:= concat("",["Invalid region: '", sprintf("%s", [results_set]),"'. The allowed regions are: ", sprintf("%s", [allowed_set])])
}