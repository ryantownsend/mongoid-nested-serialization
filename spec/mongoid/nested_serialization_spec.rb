require "spec_helper"

describe Mongoid::NestedSerialization do
  describe "::included" do
    let(:document) do
      Class.new do
        include Mongoid::Document
      end
    end
    
    it "should be included in any Mongoid::Document models" do
      expect(document.included_modules).to include Mongoid::NestedSerialization
    end
    
    it "should provide a ::find_by_json method" do
      expect(document).to respond_to :find_by_json
    end
    
    it "should provide a #finder_json method" do
      expect(document.new).to respond_to :finder_json
    end
  end

end
