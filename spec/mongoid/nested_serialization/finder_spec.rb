require "spec_helper"

describe Mongoid::NestedSerialization::Finder do
  let(:account) { Mongoid::NestedSerialization::Test::Account.create }
  let(:item) { account.items.create }
  let(:photo) { item.photos.create }
  
  describe "#find" do
    it "should find top-level objects" do
      result = account.class.find_by_json(account.finder_json)
      expect(result).to eq account
    end
    
    it "should find second-level objects" do
      result = item.class.find_by_json(item.finder_json)
      expect(result).to eq item
    end
    
    it "should find third-level objects" do
      result = photo.class.find_by_json(photo.finder_json)
      expect(result).to eq photo
    end
  end

end
