require "mongoid/nested_serialization"
require "multi_json"

module Mongoid
  module NestedSerialization
    class Finder
      def self.find(json)
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
      
      private
      # parse the raw JSON data into a hash
      def self.parse_input(json)
        MultiJson.load(json)
      end
      
      # load the top level object directly with the collection
      def self.top_level_object(data)
        data["class_name"].constantize.find(data["id"])
      end
      
      # load an object nested within another, using the data
      def self.nested_object(object, data)
        object.send(data["association"]).find(data["id"])
      end
    end
  end
end
