module RBAC

  class Permissions < Set

    def find_or_create_with_operation_and_object(operation, object)
      found(find_with_operation_and_object(operation, object)) || [create(Permission.new(operation, object))]
    end

    def find_with_operation_and_object(operation, object)
      select{|x| x.operation == operation and x.object == object }
    end

    def find_with_operation(operation)
      select{|x| x.operation == operation }
    end

    def find_with_object(object)
      select{|x| x.object == object }
    end

  end

end
