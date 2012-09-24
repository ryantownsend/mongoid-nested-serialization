require "multi_json"

module Mongoid
  module NestedSerialization
    class Serializer
      def initialize(object)
        @object = object
      end
      
      # spits out a JSON hash which can be used to relocate
      # the object in the collection tree
      def to_json
        # convert the result to JSON
        MultiJson.dump(to_hash)
      end

      # spits out a hash which can be used to relocate
      # the object in the collection tree
      def to_hash
        if object.embedded?
          # select the relation for the parent object
          parent_relation = object.relations.select do |k,v|
            v.macro == :embedded_in && v.class_name == object._parent.class.name
          end.values.first
          # embed this in the parent's hash
          self.class.new(object._parent).to_hash.merge(embedded: {
            association: parent_relation.inverse_of,
            id: object.id
          })
        else # !embedded?
          { class_name: object.class.name, id: object.id }
        end
      end
      
      private
      def object
        @object
      end
    end
  end
end
