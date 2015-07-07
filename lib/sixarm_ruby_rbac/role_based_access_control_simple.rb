# -*- coding: utf-8 -*-
=begin rdoc

RoleBasedAccessControlSimple is the simple implementation of the RoleBasedAccessControlAbstract class.

=end

require "sixarm_ruby_rbac"

class RoleBasedAccessControlSimple < RoleBasedAccessControlAbstract

  def initialize
    @users=RBAC::Users.new
    @roles=RBAC::Roles.new
    @sessions=RBAC::Sessions.new
    @permissions=RBAC::Permissions.new
    @assignments=RBAC::Assignments.new
    @grants=RBAC::Grants.new
    @operations=RBAC::Operations.new
    @objects=RBAC::Objects.new
  end

  def add_user(user)
    super(user)
    @users.add(user)
    return
  end

  def delete_user(user) 
    super(user)
    @users.delete(user)
    return
  end

  def add_role(role)
    super(role)
    @roles.add(role)
    return
  end

  def delete_role(role)
    super(role)
    @roles.delete(role)
    return
  end

  def assign_user(user, role)
    super(user, role)
    assignment = @assignments.find_or_create_with_user_and_role(user, role).first or raise ArgumentError.new('assign_user: @assignments.find_or_create_with_user_and_role: ' + [user, role].inspect)
    @assignments.add(assignment)
    return
  end

  def deassign_user(user, role)
    super(user, role)
    assignment = @assignments.find_with_user_and_role(user, role).first or raise ArgumentError.new([user, role].inspect)
    @assignments.delete(assignment)
    return
  end

  def grant_permission(operation, object, role)
    super(operation, object, role)
    permission = @permissions.find_or_create_with_operation_and_object(operation, object).first or raise ArgumentError.new([operation, object].inspect)
    grant = @grants.find_or_create_with_permission_and_role(permission, role).first or raise ArgumentError.new([permission, role].inspect)
    @grants.add(grant)
    return
  end

  def revoke_permission(operation, object, role)
    super(operation, object, role)
    permission = @permissions.find_with_operation_and_object(operation, object).first or raise ArgumentError.new([operation, object, permissions].inspect)
    grant = @grants.find_with_permission_and_role(permission, role).first or raise ArgumentError.new([permission, role].inspect)
    @grants.delete(grant)
    return
  end

  def create_session(user, session)
    super(user, session)
    @sessions.add(session)
    session.user=user
    return
  end

  def delete_session(user, session)
    super(user, session)
    @sessions.delete(session)
    return
  end

  def add_active_role(user, session, role)
    super(user, session, role)
    session.active_roles.add(role)
    return
  end

  def drop_active_role(user, session, role)
    super(user, session, role)
    session.active_roles.delete(role)
    return
  end

  def check_access(session, operation, object) #=> boolean 
    super(session, operation, object)
    roles = active_roles(session)
    permission = @permissions.find_with_operation_and_object(operation, object).first or raise ArgumentError.new([operation, object, permissions].inspect)
    grants = @grants.find_with_permission(permission).first or raise ArgumentError.new([permission].inspect)
    return false  #TODO
  end

  def assigned_users(role) #=> users
    super(role)
    assignments_with_role(role).map{|assignment| assignment.user}
  end

  def assigned_roles(user) #=> roles
    super(user)
    assignments_with_user(user).map{|assignment| assignment.role}
  end

  def role_permissions(role) #=> permissions
    super(role)
    return RBAC::Grants.find_with_role(role).map{|_grant| _grant.permission }
  end

  def user_permissions(user) #=> permissions
    super(user)
    roles = assigned_roles(user)
    return @grants.find_with_roles(roles).map{|_permission, _role| _permission}
  end

  def session_roles(session) #=> roles
    super(session)
    return assigned_roles(session.user)
  end

  def session_permissions(session) #=> permissions
    super(session)
    return user_permissions(session.user)
  end

  def role_operations_on_object(role, object) #=> operations
    super(role, object)
    return role_permissions(role).select{|_operation, _object| _object == object}.map{|_operation, _object| _object}
  end

  def user_operations_on_object(user, object) #=> operations
    super(user, object)
    return user_permissions(user).select{|_operation, _object| _object == object}.map{|_object, _operations| _object}
  end

  def add_operation(operation)
    super(operation)
    @operations.add(operation)
    return
  end

  def delete_operation(operation) 
    super(operation)
    @operations.delete(operation)
    return
  end

  def add_object(object)
    super(object)
    @objects.add(object)
    return
  end

  def delete_object(object) 
    super(object)
    @objects.delete(object)
    return
  end


  ##########################################################################
  #
  #  Helpers
  #
  ##########################################################################


  def users() #=> users
    super()
    return @users
  end

  def users=(users)
    super(users)
    @users=users
    return
  end

  def users_include?(user) 
    super(user)
    return @users.any?{|_user| _user.name == user.name}
  end

  def roles() #=> roles
    super()
    return @roles
  end

  def roles=(roles)
    super(roles)
    @roles=roles
    return
  end

  def roles_include?(role)
    super(role)
    return @roles.any?{|_role| _role.name == role.name}
  end
  
  def permissions() #=> permissions
    super()
    return @permissions
  end
  
  def permissions=(permissions)
    super(permissions)
    @permissions=permissions
    return
  end

  def permissions_include?(operation, object)
    super(operation, object)
    return @permissions.any?{|_permission| _permission.operation == operation and _permission.object == object}
  end

  def operation_object_pair_represents_permission?(operation, object)
    super(operation, object)
    return (operation.kind_of?(RBAC::Operation) and object.kind_of?(RBAC::Object))
  end

  def sessions() #=> sessions
    super()
    return @sessions
  end

  def sessions=(sessions)
    super(sessions)
    @sessions=sessions
    return
  end
  
  def sessions_include?(session)
    super(session)
    return @sessions.any?{|_session| _session.name == session.name}
  end

  def active_roles(session) #=> roles
    super(session)
    return session.active_roles
  end

  def active_roles_include?(role, session)
    super(role, session)
    return session.active_roles.include?(role)
  end

  def assignments() #=> assignments
    super()
    return @assignments
  end

  def assignments=(assignments)
    super(assignments)
    @assignments=assignments
    return
  end

  def assignments_include?(user, role) 
    super(user, role)
    return @assignments.any?{|_assignment| _assignment.user == user and _assignment.role == role}
  end

  def session_active_role_set_is_subset_of_user_role_set?(session, user)
    super(session, user)
    active_roles = session.active_roles
    user_roles = Set.new(@assignments.select{|_assignment| _assignment.user == user}.map{|_assignment| _assignment.role})
    active_roles.subset?(user_roles)
  end

  def user_owns_session?(user, session)
    super(user, session)
    return user == session.user
  end

  def operations() #=> operations
    super()
    return @operations
  end

  def operations=(operations)
    super(operations)
    @operations = operations
    return
  end
  
  def operations_include?(operation)
    super(operation)
    return @operations.include?(operation)
  end

  def objects() #=> objects
    super()
    return @objects
  end

  def objects=(objects)
    super(objects)
    @objects = objects
    return
  end

  def objects_include?(object)
    super(object)
    return @objects.include?(object)
  end

end




