# SixArm.com » Ruby » <br> RBAC: Role Based Access Control

* Doc: <http://sixarm.com/sixarm_ruby_rbac/doc>
* Gem: <http://rubygems.org/gems/sixarm_ruby_rbac>
* Repo: <http://github.com/sixarm/sixarm_ruby_rbac>
* Email: Joel Parker Henderson, <joel@sixarm.com>


## Introduction

Ruby interface for the RBAC (Role Based Access Control) specification:

  * ANSI INCITS 359-2004
  * American National Standards Institute, Inc.
  * February 3, 2004

For docs go to <http://sixarm.com/sixarm_ruby_rbac/doc>

Want to help? We're happy to get pull requests.


## Install quickstart

Install:

    gem install sixarm_ruby_rbac

Bundler:

    gem "sixarm_ruby_rbac", "~>1.0.4"

Require:

    require "sixarm_ruby_rbac"


## Install with security (optional)

To enable high security for all our gems:

    wget http://sixarm.com/sixarm.pem
    gem cert --add sixarm.pem
    gem sources --add http://sixarm.com

To install with high security:

    gem install sixarm_ruby_rbac --test --trust-policy HighSecurity


## What is Core RBAC?

Core RBAC includes tese basic data elements:

  * user
  * assignment
  * role
  * grant
  * permission
  * operation
  * object
  
Association basics:

  * a user has many assignments, and has many roles through assignments
  * a role has many grants, and has many permissions through grants
  * a permission has many operations, and has many objects through operations
  
## RBAC model

The RBAC model as a whole is fundamentally defined in terms of individual
users being assigned to roles and permissions being assigned to roles.
A role is a means for naming many-to-many relationships 
among individual users and permissions. In addition, the core RBAC
model includes a set of sessions (SESSIONS) where each session is 
a mapping between a user and an activated subset of roles that are
assigned to the user.


## Users

A user is defined as a human being. Although the concept of a user 
can be extended to include machines, networks, or intelligent autonomous
agents, the definition is limited to a person in this document for
simplicity reasons. 


## Roles

A role is a job function within the context of an organization 
with some associated semantics regarding the authority and 
responsibility conferred on the user assigned to the role.


## Permissions

Permission is an approval to perform an operation on one or more
RBAC protected objects.


## Operations

An operation is an executable image of a program, which upon invocation
executes some function for the user. The types of operations and objects
that RBAC controls are dependent on the type of system in which it will
be implemented. For example, within a file system, operations might 
include read, write, and execute; within a database management system, 
operations might include insert, delete, append and update.


## Objects

The purpose of any access control mechanism is to protect system resources (i.e.,
protected objects). Consistent with earlier models of access control an object is an entity
that contains or receives information. 


## System Implementations

For a system that implements RBAC, the objects
can represent information containers (e.g., files, directories, in an operating system,
and/or columns, rows, tables, and views within a database management system) or
objects can represent exhaustible system resources, such as printers, disk space, and CPU
cycles. 

The set of objects covered by RBAC includes all of the objects listed in the
permissions that are assigned to roles.


## For More Information

Please see the complete ANSI 359-2004 pdf document.

http://www.list.gmu.edu/journals/tissec/ANSI+INCITS+359-2004.pdf


## Roadmap

Possible future upgrades:

  * 6.2 Hierarchical RBAC
  * 6.3 Static Separation of Duty (SSD) Relations.
  * 6.4 Dynamic Separation of Duty (SSD) Relations.

## Changes

* 2012-03-14 1.0.0 Update docs, tests
## License

You may choose any of these open source licenses:

  * Apache License
  * BSD License
  * CreativeCommons License, Non-commercial Share Alike
  * GNU General Public License Version 2 (GPL 2)
  * GNU Lesser General Public License (LGPL)
  * MIT License
  * Perl Artistic License
  * Ruby License

The software is provided "as is", without warranty of any kind, 
express or implied, including but not limited to the warranties of 
merchantability, fitness for a particular purpose and noninfringement. 

In no event shall the authors or copyright holders be liable for any 
claim, damages or other liability, whether in an action of contract, 
tort or otherwise, arising from, out of or in connection with the 
software or the use or other dealings in the software.

This license is for the included software that is created by SixArm;
some of the included software may have its own licenses, copyrights, 
authors, etc. and these do take precedence over the SixArm license.

Copyright (c) 2005-2013 Joel Parker Henderson
