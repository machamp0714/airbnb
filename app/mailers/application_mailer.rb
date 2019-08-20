# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "no-reply-airbnb@example.com"
  layout "mailer"
end
