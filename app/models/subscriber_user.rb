class SubscriberUser < User
  #Nota: Cuando uno finaliza la suscripcion tambien pierde el acceso a ver las noticias completas.

  acts_as_authentic do |c|
    c.require_login_field = false
    c.require_password_field = false
  end

  named_scope :active, { :conditions => { :active => true } }

  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end

  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end

  def activate!
    self.active = true
    save
  end

  private
end
