class User < ActiveRecord::Base
  has_many :recommendations

  self.inheritance_column = "user_kind"
  validates_presence_of :user_kind

  validates_confirmation_of :email, :message => "should match confirmation"

  def initialize(attributes = nil)
    super
  end

  #def deliver_password_reset_instructions!
  #  reset_persistence_token!
  #  Notifier.deliver_password_reset_instructions(self)
  #end
end
