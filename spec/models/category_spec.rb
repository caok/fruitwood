require 'spec_helper'

describe Category do
  let(:category) { build :category }
  subject { category }

  context "pass validation" do
    it "passes validation with all valid informations" do
      expect(build :category).to be_true
    end
  end

  context "fails validation" do
    it "with a blank name" do
      category.name = ''
      expect(category.save).to be_false
    end

    it "with a duplicated name" do
      create :category, :name => category.name
      expect(category.save).to be_false
    end
  end
end
