require 'spec_helper'

describe "Categories" do
  describe "GET /categories" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get categories_path
      # without permission
      response.status.should be(302)
    end
  end
end
