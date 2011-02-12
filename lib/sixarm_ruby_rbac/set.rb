require 'set'

module RBAC

  class Set < Set
  
    # Add the item to the set then return the item.
    # This is a helper for our find_and_create_xxx methods
    def create(item)
      add(item)
      return item
    end

    # If there are items then return them, otherwise return nil.
    # This is a helper for our find_and_create_xxx methods.
    def found(items)
      items.size>0 ? found : nil
    end

  end

end
    
