require 'sinatra'
require 'haml'
require 'trello'

# Read in the trello config from the environment. Halts if any config value is
# missing.
TRELLO_CONF = %w(TRELLO_KEY TRELLO_TOKEN TRELLO_BOARD).
  reduce({}) do |conf, vname|
    abort "Please set #{vname} in the environment" unless ENV.has_key? vname
    conf_key = vname.split('_').last.downcase.to_sym
    conf.merge! conf_key => ENV[vname]
  end

Trello.configure do |config|
  config.developer_public_key = TRELLO_CONF[:key]
  config.member_token = TRELLO_CONF[:token]
end

helpers do

  def current_day_of_week
    Time.now.strftime("%A")
  end

  def board
    @board ||= Trello::Board.find TRELLO_CONF[:board]
  end

end

get '/' do
  haml :day
end
