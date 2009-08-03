class SubscriberUser < User
  acts_as_authentic do |c|
    c.require_login_field = false
    c.require_password_field = false
  end

  private
end
