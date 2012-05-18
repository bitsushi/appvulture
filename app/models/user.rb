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
#  password_reset_sent_at :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#

class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation

  validates :email, presence: true, uniqueness: true, email_format: true
  validates_presence_of :password, on: 'create'

  state_machine initial: 'unvalidated'

  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end