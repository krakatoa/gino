class Recommendation < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user, :email
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
end
