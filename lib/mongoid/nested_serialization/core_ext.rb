module Mongoid
  module Document
    def self.included(base)
      super
      base.send(:include, Mongoid::NestedSerialization)
    end
  end
end