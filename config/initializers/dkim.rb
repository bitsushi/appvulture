# Configure dkim globally (see above)
Dkim::domain      = ENV['DKIM_DOMAIN']
Dkim::selector    = ENV['DKIM_SELECTOR']
Dkim::private_key = open('config/dkim_private_key.pem').read
Dkim::signable_headers = Dkim::DefaultHeaders - %w{Message-ID Resent-Message-ID Date Return-Path Bounces-To}

# This will sign all ActionMailer deliveries
ActionMailer::Base.register_interceptor(Dkim::Interceptor)
