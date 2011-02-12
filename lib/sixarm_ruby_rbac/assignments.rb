module RBAC

  class Assignments < Set

    def find_or_create_with_user_and_role(user, role)
      found(find_with_user_and_role(user, role)) || [create(Assignment.new(user, role))]
    end

    def find_with_user_and_role(user, role)
      select{|x| x.user == user and x.role == role}
    end
    
    def find_with_user(user)
      select{|x| x.user == user}
    end

    def find_with_role(role)
      select{|x| x.role == role}
    end

  end

end
