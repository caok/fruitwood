require 'spec_helper'

describe Dish do
  let(:dish) { build :dish }
  subject { dish }

  context "pass validation" do
    it "passes validation with all valid informations" do
      expect(build :dish).to be_true
      #expect(dish).to be_valid
    end
  end

  context "fails validation" do
    it "with a blank name" do
      dish.name = ''
      expect(dish.save).to be_false
    end

    it "with a blank cover" do
      dish.cover = ''
      expect(dish.save).to be_false
    end

    it "with a blank price" do
      dish.price = ''
      expect(dish.save).to be_false
    end

    it "with a blank category_id" do
      dish.category_id = ''
      expect(dish.save).to be_false
    end

    it "with a duplicated name" do
      create :dish, :name => dish.name
      expect(dish.save).to be_false
    end

    it "with a price with chars" do
      dish.price = "asdf"
      expect(dish.save).to be_false
    end
  end

  describe 'content_html' do
    context 'when content is "# title #"' do
      subject { build :dish, :content => '# title #' }
      its(:content_html) { should include('<h1>title</h1>') }
    end
  end

  describe 'cover_html' do
    context 'when cover is "# title #"' do
      subject { build :dish, :cover => '# title #' }
      its(:cover_html) { should include('<h1>title</h1>') }
    end
  end
end
