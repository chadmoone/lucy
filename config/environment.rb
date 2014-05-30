# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Rails.application.initialize!


Time::DATE_FORMATS[:basic_date_time] = "%b %e, %Y - %I:%M %p"

labor_day = Date.parse("September 3, 2012")
BusinessTime::Config.holidays << labor_day
BusinessTime::Config.end_of_workday = "4:00 pm"