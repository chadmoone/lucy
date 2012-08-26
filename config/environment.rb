# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Lucy::Application.initialize!


Time::DATE_FORMATS[:basic_date_time] = "%b %e, %Y - %I:%M %p"