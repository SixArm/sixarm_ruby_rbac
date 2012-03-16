# -*- coding: utf-8 -*-
=begin rdoc
Please see README
=end


['role_based_access_control_abstract',
 'role_based_access_control_simple',
 # Abstract Model Set
 'set',
 # Concrete Models and Sets
 'user','users',
 'role','roles',
 'assignment','assignments',
 'session','sessions',
 'operation','operations',
 'object','objects',
 'permission','permissions',
 'grant','grants',
 # Errors
 'user_found_error','user_not_found_error',
 'role_found_error','role_not_found_error',
 'assignment_found_error','assignment_not_found_error',
 'session_found_error','session_not_found_error',
 'operation_found_error','operation_not_found_error',
 'object_found_error','object_not_found_error',
 'permission_found_error','permission_not_found_error',
 'grant_found_error','grant_not_found_error',
 'active_role_found_error','active_role_not_found_error',
 'operation_object_pair_does_not_represent_permission_error',
 'session_active_role_set_is_not_subset_of_user_role_set_error',
 'session_not_owned_by_user_error'
].map{|x|
  require File.dirname(__FILE__) + "/sixarm_ruby_rbac/#{x}.rb"
}




