package torque

import input as tfplan

# --- Validate azure vm types ---

get_basename(path) = basename{
    arr := split(path, "/")
    basename:= arr[count(arr)-1]
}

contains(arr, elem){
    arr[_] == elem
}

deny[reason] {
    resource := tfplan.resource_changes[_]
    get_basename(resource.provider_name) == "azurerm"
    vm_size:= tfplan.resource_changes[_].change.after.vm_size
    contains(data.prohibited_vm_size, vm_size)
    reason:= concat("",["Invalid vm type: '", vm_size, "'. The prohibited vm types are: ", sprintf("%s", [data.prohibited_vm_sizes])])
}
