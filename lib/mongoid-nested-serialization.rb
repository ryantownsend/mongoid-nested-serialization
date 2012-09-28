require "mongoid"
require "mongoid/nested_serialization/version"
require "mongoid/nested_serialization"

module Mongoid
  module Document
    def self.included(base)
      super
      base.send(:include, Mongoid::NestedSerialization)
    end
  end
end