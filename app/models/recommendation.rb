class Recommendation < ActiveRecord::Base
  belongs_to :subscriber_user

  validates_presence_of :subscriber_user, :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
end
