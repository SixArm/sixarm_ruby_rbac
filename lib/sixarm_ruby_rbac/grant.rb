module RBAC

  class Grant
    
    attr_accessor :permission
    attr_accessor :role
    
    def initialize(permission, role)
      @permission = permission
      @role = role
    end

  end

end
