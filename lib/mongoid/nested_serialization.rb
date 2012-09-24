require "mongoid/nested_serialization/core_ext"
require "mongoid/nested_serialization/finder"
require "mongoid/nested_serialization/serializer"

module Mongoid
  module NestedSerialization
    def self.included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
    end
    
    module ClassMethods
      def find_by_json(json)
        Mongoid::NestedSerialization::Finder.find(json)
      end
    end
    
    module InstanceMethods
      def finder_json
        Mongoid::NestedSerialization::Serializer.new(self).to_json
      end
    end
  end
end