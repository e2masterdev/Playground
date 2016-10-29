require_relative 'boot'
require 'certified'
#require 'rails/all'
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "action_cable"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Playground
  class Application < Rails::Application
    ActionMailer::Base.smtp_settings = {
        :address              => 'smtp.gmail.com',
        :domain               => 'mail.google.com',
        :port                 => 587,
        :user_name            => ENV['my_mail_address'],
        :password             => ENV['my_mail_password'],
        :authentication       => 'login',
        :enable_starttls_auto => true
    }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
