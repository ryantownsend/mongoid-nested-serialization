module Mongoid
  module NestedSerialization
    module Test
      # top level object
      class Account
        include ::Mongoid::Document
        
        embeds_many :items #, class_name: "Mongoid::NestedSerialization::Test::Item"
      end
      
      # second level object
      class Item
        include ::Mongoid::Document
        
        embedded_in :account, inverse_of: :items
        embeds_many :photos
      end
      
      # third level object
      class Photo
        include ::Mongoid::Document
      
        embedded_in :item, inverse_of: :photos
      end
    end
  end
end