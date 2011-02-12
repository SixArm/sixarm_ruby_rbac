module RBAC

  class Permission
    
    attr_accessor :operation
    attr_accessor :object
    
    def initialize(operation, object)
      @operation=operation
      @object=object
    end

  end

end
