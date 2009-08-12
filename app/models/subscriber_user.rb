class SubscriberUser < User
  #Nota: Cuando uno finaliza la suscripcion tambien pierde el acceso a ver las noticias completas.

  acts_as_authentic do |c|
    c.merge_validates_length_of_login_field_options(:allow_blank => true)
    c.merge_validates_uniqueness_of_login_field_options(:allow_blank => true)
    c.merge_validates_format_of_login_field_options(:allow_blank => true)
    c.merge_validates_length_of_password_field_options(:allow_blank => true)
    c.merge_validates_confirmation_of_password_field_options(:allow_blank => true)
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
