# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_google_groups_scraper_session',
  :secret      => 'd10bfb6335cdd65824c96029f225d7fd75159e8233be85d5be89747367512562816934fe27b8abb351a224b4845f3029665222112c3ba5320c32e7f87c68bbdd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
