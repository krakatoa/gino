class Notifier < ActionMailer::Base
  default_url_options[:host] = "#{HOSTNAME_URI.host}:#{HOSTNAME_URI.port}"

  def activation_instructions(user)
    subject       "Activation Instructions"
    from          "fedario@gmail.com"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token, :locale => user.language), :language => user.language
  end

  def activation_confirmation(user)
    subject       "Activation Complete"
    from          "fedario@gmail.com"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
  end

  def newsletter(news, user)
    subject       "Newsletter"
    from          "fedario@gmail.com"
    recipients    user.email
    sent_on       Time.now
    if user.plain_format?
      content_type  "text/plain"
      body          render_message("plain_newsletter", :news => news)
    else
      content_type  "text/html"
      body          render_message("newsletter", :news => news)
    end
  end
end