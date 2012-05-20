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

class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation

  validates :email, presence: true, uniqueness: true, email_format: true
  validates_presence_of :password, on: 'create'
  # validates_length_of :password, minimum: 6

  state_machine initial: 'unvalidated'

  before_create { generate_token(:auth_token) }

  before_save :clean_up_attributes

  def clean_up_attributes
    self.email.downcase!
  end

  has_many :lenses, foreign_key: :watcher_id, dependent: :destroy
  has_many :apps, through: :lenses, foreign_key: :app_id, dependent: :destroy #make into watched_apps

  def watching?(app)
    app.watchers.include?(self)
  end

  def lens_for(app)
    self.lenses.where(app_id: app.id).first
  end

  def self.uber_find_or_create_by_email(email)
    unless user = User.find_by_email(email)
      user = User.create(email: email, password: SecureRandom.urlsafe_base64)
      # user.send_password_reset
    end
    return user
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
