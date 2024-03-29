# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(100)
#  password_digest        :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  state                  :string(20)
#  auth_token             :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#

require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create(:user) }

  it "should .downcase email addresses" do
    FactoryGirl.create(:user, email: 'Testing@test.com')
    .email.should eq('testing@test.com')
  end

  it { should have_many(:apps) }
  it "should have watching? method" do
    app = FactoryGirl.create(:app)
    user.watching?(app).should be_false
    user.apps << app
    user.watching?(app).should be_true
  end

  it "should have uber_find_or_create_by_email" do
    FactoryGirl.create(:user, email: 'test@test.com')

    User.uber_find_or_create_by_email('test@test.com')
    .email.should eq('test@test.com')

    User.uber_find_or_create_by_email('newuser@test.com')
    .email.should eq('newuser@test.com')
  end

  # it "should have lens_for method" do
  #   app = FactoryGirl.create(:app)
  #   user.apps << app
  #   user.lens_for(app).should eq(app.lens)
  # end

  describe "creating user" do

    it { should validate_presence_of(:email) }

    it do
      FactoryGirl.create(:user)
      should validate_uniqueness_of(:email)
    end

    it "should validate email" do
      FactoryGirl.build(:user, email: 'notvalidemail.com')
      .errors_on(:email).should include('is not formatted properly')

      FactoryGirl.build(:user, email: 'test+withfilter@email.com')
      .should be_valid
    end

    it { should validate_presence_of(:password) }

    it "should validate that password matches password_confirmation" do
      FactoryGirl.build(:user, password_confirmation: 'unequal')
      .errors_on(:password).should include("doesn't match confirmation")
    end

    it "should have an initial state" do
      user.state.should_not be_blank
    end

    it "should generate unique auth_token on create" do
      one = FactoryGirl.create(:user).auth_token
      two = FactoryGirl.create(:user).auth_token
      one.should_not be_blank
      one.should_not eq(two)
    end

  end

  describe "#send_password_reset" do

    it "generates a unique password_reset_token each time" do
      user.send_password_reset
      last_token = user.password_reset_token
      user.send_password_reset
      user.password_reset_token.should_not eq(last_token)
    end

    it "saves the time the password reset was sent" do
      user.send_password_reset
      user.reload.password_reset_sent_at.should be_present
    end

    it "delivers email to user" do
      user.send_password_reset
      last_email.to.should include(user.email)
    end

  end

end
