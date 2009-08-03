class Recommendation < ActiveRecord::Base
  belongs_to :subscriber_user

  validates_presence_of :subscriber_user, :email
end
