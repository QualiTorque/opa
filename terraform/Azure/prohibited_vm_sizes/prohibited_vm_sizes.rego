package torque

import input as tfplan

# --- Validate azure vm sizes ---

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
    vm_size:= tfplan.planned_values.root_module.resources.values.vm_size
    contains(data.prohibited_vm_sizes, vm_size)
    reason:= concat("",["Invalid vm size: '", vm_size, "'. The prohibited vm sizes are: ", sprintf("%s", [data.prohibited_vm_sizes])])
}
