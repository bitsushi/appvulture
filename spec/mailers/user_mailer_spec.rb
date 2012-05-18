require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    let(:user) { FactoryGirl.create(:user, password_reset_token: 'anything') }
    let(:mail) { UserMailer.password_reset(user) }

    it "sends user password reset url" do
      mail.subject.should include("Password Reset")
      mail.to.should eq([user.email])
      mail.body.should match(edit_password_reset_path(user.password_reset_token))
    end

    it "sends user signup confirmation"
  end

end