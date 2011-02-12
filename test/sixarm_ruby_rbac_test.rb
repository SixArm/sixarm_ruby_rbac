require 'test/unit'
require 'sixarm_ruby_role_based_access_control'

class RoleBasedAccessControlTest < Test::Unit::TestCase

  def setup

    @rbac=RoleBasedAccessControlSimple.new
  
    @user =
    @user_1 = RBAC::User.new('user_1')
    @user_2 = RBAC::User.new('user_2')
    @user_3 = RBAC::User.new('user_3')

    @role =
    @role_1 = RBAC::Role.new('role_1')
    @role_2 = RBAC::Role.new('role_2')
    @role_3 = RBAC::Role.new('role_3')

    @session =
    @session_1 = RBAC::Session.new('session_1')
    @session_2 = RBAC::Session.new('session_2')
    @session_3 = RBAC::Session.new('session_3')

    @operation =
    @operation_1 = RBAC::Operation.new('operation_1')
    @operation_2 = RBAC::Operation.new('operation_2')
    @operation_3 = RBAC::Operation.new('operation_3')

    @object =
    @object_1 = RBAC::Object.new('object_1')
    @object_2 = RBAC::Object.new('object_2')
    @object_3 = RBAC::Object.new('object_3')

    @permission =
    @permission_1 = RBAC::Permission.new(@operation_1, @object_1)
    @permission_2 = RBAC::Permission.new(@operation_2, @object_2)
    @permission_3 = RBAC::Permission.new(@operation_3, @object_3)

    @users=Set.new([
      @user_1,
      @user_2,
    ])

    @roles=Set.new([
      @role_1,
      @role_2, 
    ])

    @sessions=Set.new([
      @session_1,
      @session_2,
    ])

    @operations=Set.new([
      @operation_1,
      @operation_2,
    ])

    @objects=Set.new([
      @object_1,
      @object_2,
    ])

    @permissions=Set.new([
      @permission_1,
      @permission_2,
    ])

  end

  def setup_add_active_role
    @rbac.add_user(@user)
    @rbac.add_role(@role)
    @rbac.assign_user(@user, @role)
    @rbac.create_session(@user, @session)
  end

  def setup_drop_active_role
    @rbac.add_user(@user)
    @rbac.add_role(@role)
    @rbac.assign_user(@user, @role)
    @rbac.create_session(@user, @session)
    @rbac.add_active_role(@user, @session, @role)
  end

  def setup_check_access
    @rbac.add_user(@user)
    @rbac.add_role(@role)
    @rbac.assign_user(@user, @role)
    @rbac.create_session(@user, @session)
    @rbac.add_active_role(@user, @session, @role)
    @rbac.grant_permission(@operation, @object, @role)
  end


  #######################################################################################
  #
  # ANSI
  #
  #######################################################################################

  def test_add_user_success
    assert_nothing_raised do 
      @rbac.add_user(@user)
    end
  end

  def test_add_user_failure_because_user_is_duplicate
    @rbac.add_user(@user)
    assert_raise UserFound do
      @rbac.add_user(@user)
    end
  end

  def test_delete_user_success
    @rbac.add_user(@user)
    assert_nothing_raised do
      @rbac.delete_user(@user)
    end
  end

  def test_delete_user_failure_because_user_not_found
    assert_raise UserNotFound do
      @rbac.delete_user(@user)
    end
  end

  def test_add_role_success
    assert_nothing_raised do 
      @rbac.add_role(@role)
    end
  end

  def test_add_role_failure_because_role_is_duplicate
    @rbac.add_role(@role)
    assert_raise RoleFound do 
      @rbac.add_role(@role)
    end
  end

  def test_delete_role_success
    @rbac.add_role(@role)
    assert_nothing_raised do 
      @rbac.delete_role(@role)
    end
  end

  def test_delete_role_failure_because_role_not_found
    assert_raise RoleNotFound do
      @rbac.delete_role(@role)
    end
  end

  def test_assign_user_success
    @rbac.add_user(@user)
    @rbac.add_role(@role)
    assert_nothing_raised do
      @rbac.assign_user(@user, @role)
    end
  end

  def test_assign_user_failure_because_user_not_found
    @rbac.add_role(@role)
    assert_raise UserNotFound do
      @rbac.assign_user(@user, @role)
    end
  end

  def test_assign_user_failure_because_role_not_found
    @rbac.add_user(@user)
    assert_raise RoleNotFound do
      @rbac.assign_user(@user, @role)
    end
  end

  def test_deassign_user_success
    @rbac.add_user(@user)
    @rbac.add_role(@role)
    @rbac.assign_user(@user, @role)
    assert_nothing_raised do
      @rbac.deassign_user(@user, @role)
    end
  end

  def test_deassign_user_failure_because_assignment_not_found
    @rbac.add_user(@user)
    @rbac.add_role(@role)
    assert_raise AssignmentNotFound do
      @rbac.deassign_user(@user, @role)
    end
  end

  def test_grant_permission_success
    @rbac.add_role(@role)
    assert_nothing_raised do
      @rbac.grant_permission(@operation, @object, @role)
    end
  end

  def test_grant_permission_failure_because_operation_object_pair_does_not_represent_permission
    @rbac.add_role(@role)
    assert_raise OperationObjectPairDoesNotRepresentPermission do
      @rbac.grant_permission(@fake, @fake, @role)
    end
  end

  def test_grant_permission_failure_because_role_not_found
    assert_raise RoleNotFound do
      @rbac.grant_permission(@operation, @object, @role)
    end
  end

  def test_revoke_permission_success
    @rbac.add_role(@role)
    @rbac.grant_permission(@operation, @object, @role)
    assert_nothing_raised do 
      @rbac.revoke_permission(@operation, @object , @role)
    end
  end

  def test_revoke_permission_failure_because_operation_object_pair_does_not_represent_permission
    @rbac.add_role(@role)
    assert_raise OperationObjectPairDoesNotRepresentPermission do 
      @rbac.revoke_permission(@fake, @fake, @role)
    end
  end

  def test_revoke_permission_failure_because_role_not_found
    assert_raise RoleNotFound do 
      @rbac.revoke_permission(@operation, @object, @role)
    end
  end

  def test_create_session_success
    @rbac.add_user(@user)
    assert_nothing_raised do 
      @rbac.create_session(@user, @session)
    end
  end

  def test_create_session_failure_because_user_not_found
    assert_raise UserNotFound do 
      @rbac.create_session(@user,  @session)
    end
  end

  def test_create_session_with_user_change_success
    # Create group 1
    user1=RBAC::User.new('user1')
    role1=RBAC::Role.new('role1')
    @rbac.add_user(user1)
    @rbac.add_role(role1)
    @rbac.assign_user(user1, role1)
    @rbac.create_session(user1,  @session)
    @rbac.add_active_role(user1, @session, role1)
    # Create group 2
    user2=RBAC::User.new('user2')
    @rbac.add_user(user2)
    @rbac.assign_user(user2, role1) # same role as above
    # Now try to repurpose the session to the other user;
    # this works because the session's active role set
    # is a subset (e.g. equal) of the user's role set.
    assert_nothing_raised do
      @rbac.create_session(user2,  @session)
    end
  end


  def test_create_session_with_user_change_failure_because_session_active_role_set_is_not_subset_of_user_role_set
    # Create group 1
    user1=RBAC::User.new('user1')
    role1=RBAC::Role.new('role1')
    @rbac.add_user(user1)
    @rbac.add_role(role1)
    @rbac.assign_user(user1, role1)
    @rbac.create_session(user1,  @session)
    @rbac.add_active_role(user1, @session, role1)
    # Create group 2
    user2=RBAC::User.new('user2')
    role2=RBAC::Role.new('role2')
    @rbac.add_user(user2)
    @rbac.add_role(role2)
    @rbac.assign_user(user2, role2)
    # Now try to repurpose the session to the other user;
    # this fails because the session's active role set
    # is a not a subset of the user's role set.
    assert_raise SessionActiveRoleSetIsNotSubsetOfUserRoleSet do 
      @rbac.create_session(user2,  @session)
    end
  end

  def test_delete_session_success
    @rbac.add_user(@user)
    @rbac.create_session(@user, @session)
    assert_nothing_raised do
      @rbac.delete_session(@user,  @session)
    end
  end

  def test_delete_session_failure_because_session_not_found
    @rbac.add_user(@user)
    assert_raise SessionNotFound do
      @rbac.delete_session(@user,  @session)
    end
  end

  def test_add_active_role_success
    setup_add_active_role
    assert_nothing_raised do 
      @rbac.add_active_role(@user, @session, @role)
    end
  end

  def test_add_active_role_failure_because_role_not_assigned_to_user
    setup_add_active_role
    @rbac.add_role(@role_2)
    assert_raise AssignmentNotFound do 
      @rbac.add_active_role(@user, @session, @role_2)
    end
  end

  def test_add_active_role_failure_because_session_not_owned_by_user
    setup_add_active_role
    @rbac.add_user(@user_2)
    @rbac.assign_user(@user_2, @role)
    assert_raise SessionNotOwnedByUser do 
      @rbac.add_active_role(@user_2, @session, @role)
    end
  end

  def test_drop_active_role_success
    setup_drop_active_role
    assert_nothing_raised do 
      @rbac.drop_active_role(@user, @session, @role)
    end
  end

  def test_drop_active_role_failure_because_role_not_active_role
    setup_drop_active_role
    @rbac.add_role(@role_2)
    assert_raise ActiveRoleNotFound do 
      @rbac.drop_active_role(@user, @session, @role_2)
    end
  end

  def test_drop_active_role_failure_because_session_not_owned_by_user
    setup_drop_active_role
    @rbac.add_user(@user_2)
    assert_raise SessionNotOwnedByUser do 
      @rbac.drop_active_role(@user_2, @session, @role)
    end
  end


end
__END__



  def test_check_access_success
    setup_check_access
    assert_nothing_raised do 
      @rbac.check_access(@session, @operation, @object)
    end
  end

  def test_check_access_failure_because_session_not_found
    setup_check_access    
    assert_raise SessionNotFound do 
      @rbac.check_access(@session_2, @operation, @object)
    end
  end

  def test_check_access_failure_because_operation_not_found
    setup_check_access
    assert_raise OperationNotFound do 
      @rbac.check_access(@session, @operation_2, @object)
    end
  end

  def test_check_access_failure_because_object_not_found
    setup_check_access
    assert_raise ObjectNotFound do 
      @rbac.check_access(@session, @operation, @object_2)
    end
  end

!!!!!!!
  def test_assigned_users_success
    rbac = RoleBasedAccessControlSimple.new
    assert_nothing_raised do 
      rbac.assigned_users(@role)
    end
  end

  def test_assigned_users_failure
    rbac = RoleBasedAccessControlSimple.new
    assert_raise ArgumentError do 
      rbac.assigned_users(@role)
    end
  end

  def test_assigned_roles_success
    rbac = RoleBasedAccessControlSimple.new
    assert_nothing_raised do 
      rbac.assigned_roles(@user)
    end
  end

  def test_assigned_roles_failure
    rbac = RoleBasedAccessControlSimple.new
    assert_raise ArgumentError do 
      rbac.assigned_roles(@user)
    end
  end

  def test_user_permissions_success
    rbac = RoleBasedAccessControlSimple.new
    rbac.add_user(@user)
    assert_nothing_raised do 
      rbac.user_permissions(@user)
    end
  end

  def test_user_permissions_failure
    rbac = RoleBasedAccessControlSimple.new
    rbac.add_user(@user)
    assert_raise ArgumentError do 
      rbac.user_permissions(@user)
    end
  end

  def test_role_permissions_success
    rbac = RoleBasedAccessControlSimple.new
    rbac.add_role(@role)
    assert_nothing_raised do 
      rbac.role_permissions(@role)
    end
  end

  def test_role_permissions_failure
    rbac = RoleBasedAccessControlSimple.new
    rbac.add_role(@role)
    assert_raise ArgumentError do 
      rbac.role_permissions(@role)
    end
  end

  def test_session_permissions_success
    rbac = RoleBasedAccessControlSimple.new
    assert_nothing_raised do
      rbac.session_permissions(@session)
    end
  end

  def test_session_permissions_failure
    rbac = RoleBasedAccessControlSimple.new
    assert_raise ArgumentError do
      rbac.session_permissions(@session)
    end
  end

  def test_role_operations_on_object_success
    rbac = RoleBasedAccessControlSimple.new
    rbac.add_role(@role)
    assert_nothing_raised do
      rbac.role_operations_on_object(@role, @object)
    end
  end

  def test_role_operations_on_object_failure
    rbac = RoleBasedAccessControlSimple.new
    assert_raise ArgumentError do
      rbac.role_operations_on_object(@role, @object)
    end
  end

  def test_user_operations_on_object_success
    rbac = RoleBasedAccessControlSimple.new
    rbac.add_user(@user)
    assert_nothing_raised do 
      rbac.user_operations_on_object(@user, @object)
    end
  end

  def test_user_operations_on_object_failure
    rbac = RoleBasedAccessControlSimple.new
    rbac.add_user(@user)
    assert_raise ArgumentError do 
      rbac.user_operations_on_object(@user, @object)
    end
  end


  #######################################################################################
  #
  # Helpers - not much to test here because implementations will do things differently.
  # 
  # We have put commented methods here as examples of what you might want to call, 
  # for your own testing,  if you are writing an implementation.
  #
  #######################################################################################

  def test_users
    rbac = RoleBasedAccessControlSimple.new
    rbac.users=@users
    #assert_equal(@users, rbac.users)
  end

  def test_users_include
    rbac = RoleBasedAccessControlSimple.new
    rbac.users=@users
    #assert( rbac.users_include?(@user))
    #assert(!rbac.users_include?('foo'))
  end

  def test_roles
    rbac = RoleBasedAccessControlSimple.new
    rbac.roles=@roles
    #assert_equal(roles, rbac.roles)
  end

  def test_roles_include
    rbac = RoleBasedAccessControlSimple.new
    rbac.roles=@roles
    #assert( rbac.roles_include?(@role))
    #assert(!rbac.roles_include?('foo'))
  end

  def test_permissions
    rbac = RoleBasedAccessControlSimple.new
    rbac.permissions=@permissions
    #assert_equal(@permissions, rbac.permissions)
  end

  def test_permissions_include
    rbac = RoleBasedAccessControlSimple.new
    rbac.permissions=@permissions
    #assert( rbac.permissions_include?(@permission))
    #assert(!rbac.permissions_include?('foo'))
  end

  def test_sessions
    rbac = RoleBasedAccessControlSimple.new
    rbac.sessions=@sessions
    #assert_equal(sessions, rbac.sessions)
  end

  def test_sessions_include
    rbac = RoleBasedAccessControlSimple.new
    rbac.sessions=@sessions
    #assert( rbac.sessions_include?(@session))
    #assert(!rbac.sessions_include?('foo'))
  end

  def test_active_roles
    rbac = RoleBasedAccessControlSimple.new
    @active_roles.each{|role| 
      rbac.add_role(role)
      rbac.add_active_role(@user, @session, role)
    }
    #assert_equal(@active_roles, rbac.active_roles)
  end

  def test_active_roles_include
    rbac = RoleBasedAccessControlSimple.new
    @active_roles.each{|role|
      rbac.add_role(role)
      rbac.add_active_role(@user, @session, role)
    }
    #assert( rbac.active_roles_include?(@active_role))
    #assert(!rbac.active_roles_include?('foo'))
  end

  def test_user_role_assignments
    rbac = RoleBasedAccessControlSimple.new
    rbac.user_role_assignments=@user_role_assignments
    #assert_equal(@user_role_assignments, rbac.user_role_assignments)
  end

  def test_user_role_assignments_include
    rbac = RoleBasedAccessControlSimple.new
    rbac.user_role_assignments=@user_role_assignments
    #assert( rbac.user_role_assignments?(@user_role_assignment))
    #assert(!rbac.user_role_assignments_include?('foo'))
  end

  def test_active_role_set_is_subset_of_roles_assigned_to_user
    rbac = RoleBasedAccessControlSimple.new
    #active_role_set_is_subset_of_roles_assigned_to_user?(@user)
  end

  def test_user_owns_session
    rbac = RoleBasedAccessControlSimple.new
    rbac.add_user(user)
    rbac.create_session(user, session)
    assert(user_owns_session?(@user, @session))
  end


end




