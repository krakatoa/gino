# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_altidus_session',
  :secret      => '369d39973668056e7adbbdca102df1186be156d146343e26b69104f823899d3a8b475abf0df1762e14057fbf5c16a0e10ce1e662948bbb959c9b618fb38b9dca'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
