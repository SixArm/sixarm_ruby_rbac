module RBAC

  class Session
    
    attr_accessor :name
    attr_accessor :user
    attr_accessor :active_roles
    
    def initialize(name)
      @name=name
      @user=nil
      @active_roles=Set.new
    end

  end

end
