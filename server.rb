require 'sinatra'
require 'haml'

require './perlisms'
require './timeslots'
require './mock_timeslots'

# TODO: visually highlight current timeslot

get '/' do
  headers 'X-Frame-Options' => "GOFORIT"
  haml :day
end

# For hacking on the UI
get '/mock' do
  @mock = true
  haml :day
end

helpers do

  def todays_timeslots
    @mock ? MockTimeslots.load : Timeslots.load
  end

  def current_day_of_week
    Time.now.strftime("%A")
  end

  def perlisms
    Perlisms
  end

end
