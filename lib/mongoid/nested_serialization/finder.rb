require "multi_json"

module Mongoid
  module NestedSerialization
    class Finder
      def initialize(klass)
        @klass = klass
      end
      
      # parse the raw JSON data into a hash
      def parse_input(json)
        MultiJson.load(json)
      end
      
      # load the top level object directly with the collection
      def top_level_object(data)
        data["class_name"].constantize.find(data["id"])
      end
      
      # load an object nested within another, using the data
      def nested_object(object, data)
        object.send(data["association"]).find(data["id"])
      end

      def find(json)
        data = parse_input(json)
        # load the top level object
        object = top_level_object(data)
        # if we have embedded stuff
        while data["embedded"]
          # work on the next level down
          data = data["embedded"]
          # find the nested object
          object = nested_object(object, data)
        end
        # once at the bottom, return the object
        object
      end
    end
  end
end
