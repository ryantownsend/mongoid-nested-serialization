module Mongoid
  module NestedSerialization
    def self.included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
    end
    
    module ClassMethods
      def find_by_json(json)
        Mongoid::NestedSerialization::Finder.new(self).find(json)
      end
    end
    
    module InstanceMethods
      def finder_json
        Mongoid::NestedSerialization::Serializer.new(self).to_json
      end
    end
  end
end