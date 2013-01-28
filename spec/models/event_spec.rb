require 'spec_helper'

describe Event do
  let(:event) { build :event }

  it "passes validation with all valid informations" do
    expect(event).to be_valid
  end

  context "fails validation" do
    it "with a blank title" do
      event.title = ''
      expect(event.save).to be_false
    end

    it "with a blank start_date" do
      event.start_date = ''
      expect(event.save).to be_false
    end

    it "with a blank end_date" do
      event.end_date = ''
      expect(event.save).to be_false
    end

    it "with start_date > end_date" do
      event.start_date = "2012-12-31"
      event.end_date = "2012-12-30"
      expect(event.save).to be_false
    end
  end

  describe 'content_html' do
    context 'when content is "# title #"' do
      subject { build :event, :content => '# title #' }
      its(:content_html) { should include('<h1>title</h1>') }
    end
  end
end
