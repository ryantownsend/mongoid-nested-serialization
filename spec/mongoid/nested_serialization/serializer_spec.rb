require "spec_helper"

describe Mongoid::NestedSerialization::Serializer do
  let(:serialized) do
    Mongoid::NestedSerialization::Serializer.new(object).to_hash
  end
  let(:account) { Mongoid::NestedSerialization::Test::Account.create }
  let(:item) { account.items.create }
  let(:photo) { item.photos.create }

  describe "#to_hash" do
    context "given a top-level object" do
      let(:object) { account }
      
      it "should not have embedded data" do
        expect(serialized.has_key?(:embedded)).to be_false
      end
    end
    
    context "given a second-level object" do
      let(:object) { item }
      
      it "should have embedded data" do
        expect(serialized.has_key?(:embedded)).to be_true
      end
      
      it "should not have double embedded data" do
        expect(serialized[:embedded].has_key?(:embedded)).to be_false
      end
    end
    
    context "given a third-level object" do
      let(:object) { photo }
      
      it "should have embedded data" do
        expect(serialized.has_key?(:embedded)).to be_true
      end
      
      it "should have double embedded data" do
        expect(serialized[:embedded].has_key?(:embedded)).to be_true
      end
    end
  end
end
