module RBAC

  class Grants < Set

    def find_or_create_with_permission_and_role(permission, role)
      found(find_with_permission_and_role(permission, role)) || [create(Grant.new(permission, role))]
    end

    def find_with_permission_and_role(permission, role)
      select{|x| x.permission == permission and x.role == role }
    end

    def find_with_permission(permission)
      select{|x| x.permission == permission }
    end

    def find_with_permissions(permissions)
      select{|x| permissions.include?(x.permission) }
    end

    def find_with_role(role)
      select{|x| x.role == role }
    end

    def find_with_roles(roles)
      select{|x| roles.include?(x.role) }
    end

  end

end
