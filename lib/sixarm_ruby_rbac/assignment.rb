module RBAC

  class Assignment

    attr_accessor :user
    attr_accessor :role

    def initialize(user, role)
      @user=user
      @role=role
    end

  end

end
