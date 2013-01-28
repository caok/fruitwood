require 'spec_helper'

describe User do
  let(:user) { build :user }
  subject { user }

  context "pass validation" do
    it "passes validation with all valid informations" do
      expect(build :user).to be_true
    end

    it "with a phone" do
      create :user, :tel => "54756464"
      expect(user.save).to be_true
    end

    it "with a mobile" do
      create :user, :tel => "13774554698"
      expect(user.save).to be_true
    end

    it "with a blank email" do
      user.email = ""
      expect(user.save).to be_true
    end
  end

  context "fails validation" do
    it "with a blank name" do
      user.name = ''
      expect(user.save).to be_false
    end

    it "with a blank tel" do
      user.tel = ''
      expect(user.save).to be_false
    end

    it "with a tel < 7 chars" do
      user.tel = "123456"
      expect(user.save).to be_false
    end

    it "with a tel > 11 chars" do
      user.tel = "123456123456"
      expect(user.save).to be_false
    end

    it "with a tel between 8 and 11 chars" do
      user.tel = "1234567890"
      expect(user.save).to be_false
    end

    it "with a duplicated tel" do
      create :user, :tel => user.tel
      expect(user.save).to be_false
    end

    it "with a password < 6 chars" do
      user.password = 'a2c4e'
      expect(user.save).to be_false
    end
  end
end
