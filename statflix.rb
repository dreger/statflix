require 'mechanize'
require 'json'

class Log
  attr_accessor :title, :hours, :date
  def initialize(title, hours, date)
    @title = title
    @hours = hours
    @date = date
  end
end

def get_data
  # Put your Netflix email and password here:
  # And please, for the love of all things security, don't publish
  # this file with the following two fields filled in :)
  user_email = ''
  user_pass  = ''

  # URIs used by Mechanize to log in to you account
  login_url = "https://signup.netflix.com/Login"
  json_url = "https://api-global.netflix.com/desktop/account/viewinghistory"

  # Log in
  a = Mechanize.new
  a.get(login_url)
  form = a.page.forms[0]
  form['email'] = user_email
  form['password'] = user_pass
  form.submit

  # Grab the JSON file of your Recently Watched history
  json_file = a.get(json_url).body
  results = JSON.parse(json_file)

  # Uncomment to have each show printed out in the Terminal
  # result['viewedItems'].each{ |i|
  #   puts "#{i['duration']}\t#{i['date']}\t#{i['title']}"
  # }

  # Store the title, hours and date in an array.
  entries = results['viewedItems'].map do |item|
              hours = (item['bookmark'].to_f / 60 / 60 ).round(2)
              Log.new(item['title'], hours, item['dateStr'])
            end


  # Get and format current date to compare against each entry's date
  todays_date = Time.new.strftime("%m/%d/%y")

  total_time_watched = 0
  total_shows_watched = 0

  puts "Shows watched today:"

  # Thanks to reddit.com/user/banderash for help cleaning up the logic here
  shows_watched_today = entries.select { |entry| entry.date == todays_date }
  shows_watched_today.each do |x|
    puts "- #{x.title}"
  end

  total_shows_watched = shows_watched_today.size
  total_time_watched = shows_watched_today.inject(0) {|sum, entry| sum + entry.hours}

  # Print data
  puts "\nYou watched #{total_shows_watched} shows for a total of #{total_time_watched.round(2)} hours today."
end

# Call the method
get_data