module RBAC

  class Object

    attr_accessor :name

    def initialize(name)
      @name=name
    end

    def ==(a)
      name==a.name
    end

  end

end
