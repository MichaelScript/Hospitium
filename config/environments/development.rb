AnimalTracker::Application.configure do
  config.eager_load = false
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  # config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  # config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = true

  # Don't care if the mailer can't send
  # config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  # config.action_dispatch.best_standards_support = :builtin
  # config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.default_url_options = { host: 'hospitium.co' }
  ActionMailer::Base.smtp_settings = {
    address: ENV.fetch('SMTP_SERVER', 'smtp.sendgrid.net'),
    port: ENV.fetch('SMTP_PORT', '587'),
    authentication: :plain,
    user_name: ENV['SENDGRID_USERNAME'],
    password: ENV['SENDGRID_PASSWORD'],
    domain: ENV['SENDGRID_DOMAIN']
  }
  ActionMailer::Base.delivery_method = :smtp

  config.cache_store = :dalli_store

  # Do not compress assets
  # config.assets.compress = false
  # config.assets.js_compressor = :closure
  # config.assets.css_compressor = :yui
  # config.assets.digest = true

  # Expands the lines which load the assets
  # config.assets.debug = true

  Paperclip.options[:command_path] = '/usr/local/bin/'
  Paperclip::Attachment.default_options[:command_path] = '/usr/local/bin'

  # config.action_controller.asset_host = ENV['HOSPITIUM_ASSET_URL']
  # Compress JavaScripts and CSS
  # config.assets.compress = true
  # config.assets.js_compressor = :closure
  # config.assets.css_compressor = :yui

  # # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # # Generate digests for assets URLs
  config.assets.digest = false
end
