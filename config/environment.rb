# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ENV['SSL_CERT_FILE'] = Rails.root.join('config', 'cacert.pem').to_s
