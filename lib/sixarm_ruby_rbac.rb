# -*- coding: utf-8 -*-

=begin rdoc

= SixArm.com » Ruby » Role Based Access Control for user authorization using ANSI INCITS 359-2004 standard

Author:: Joel Parker Henderson, joelparkerhenderson@gmail.com
Copyright:: Copyright (c) 2009-2011 Joel Parker Henderson
License:: See LICENSE.txt file

Ruby interface for the Role Based Access Control (RBAC) specification:
- ANSI INCITS 359-2004
- American National Standards Institute, Inc.
- February 3, 2004

= What is Core RBAC?

Core RBAC includes sets of five basic data elements called users (USERS),
roles (ROLES), objects (OBS), operations (OPS), and permissions (PRMS).


== RBAC model

The RBAC model as a whole is fundamentally defined in terms of individual
users being assigned to roles and permissions being assigned to roles.
A role is a means for naming many-to-many relationships
among individual users and permissions. In addition, the core RBAC
model includes a set of sessions (SESSIONS) where each session is
a mapping between a user and an activated subset of roles that are
assigned to the user.


== Users

A user is defined as a human being. Although the concept of a user
can be extended to include machines, networks, or intelligent autonomous
agents, the definition is limited to a person in this document for
simplicity reasons.


== Roles

A role is a job function within the context of an organization
with some associated semantics regarding the authority and
responsibility conferred on the user assigned to the role.


== Permissions

Permission is an approval to perform an operation on one or more
RBAC protected objects.


== Operations

An operation is an executable image of a program, which upon invocation
executes some function for the user. The types of operations and objects
that RBAC controls are dependent on the type of system in which it will
be implemented. For example, within a file system, operations might
include read, write, and execute; within a database management system,
operations might include insert, delete, append and update.


= Details

The purpose of any access control mechanism is to protect system resources (i.e.,
protected objects). Consistent with earlier models of access control an object is an entity
that contains or receives information.

== System Implementations

For a system that implements RBAC, the objects
can represent information containers (e.g., files, directories, in an operating system,
and/or columns, rows, tables, and views within a database management system) or
objects can represent exhaustible system resources, such as printers, disk space, and CPU
cycles.

The set of objects covered by RBAC includes all of the objects listed in the
permissions that are assigned to roles.


== For More Information

Please see the complete ANSI 359-2004 pdf document.

http://www.list.gmu.edu/journals/tissec/ANSI+INCITS+359-2004.pdf


== Roadmap

Possible future upgrades:
- 6.2 Hierarchical RBAC
- 6.3 Static Separation of Duty (SSD) Relations.
- 6.4 Dynamic Separation of Duty (SSD) Relations.

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




