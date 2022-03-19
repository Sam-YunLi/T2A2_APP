# initalize the stripe secret key for api
Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)