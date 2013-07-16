# Timeslot data from a Trello board

require 'hashugar'
require 'trello'

require './current_timeslot'

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

module Timeslots

  extend self

  # public api

  def load
    load_data.
      map { |slot_data| Hashugar.new slot_data }.
      reject { |slot| slot.name.chars.first == '*' }.
      each { |slot| slot[:current?] = true if CurrentTimeslot.is? slot.name }
  end

  # implementation

  def load_data
    cards.map do |card|
      {
        'name' => card.name,
        'members' => card.members.map do |mem|
          { 'full_name' => mem.full_name,
            'avatar_url' => mem.avatar_url }
        end
      }
    end
  end

  def cards
    list.try(:cards) or []
  end

  def list
    board.lists.find { |l| l.name == current_day_of_week }
  end

  def board
    Trello::Board.find TRELLO_CONF[:board]
  end

  def current_day_of_week
    Time.now.strftime("%A")
  end

end

if $0 == __FILE__

  # Run with
  # sh -c "source trello-conf.sh && TRELLO_BOARD=51ace06d8e03d65713003fcf ruby timeslots.rb"

  timeslots = []

  require 'benchmark'
  time = Benchmark.realtime { timeslots = Timeslots.load_data }
  puts "Trello API call took: #{time} seconds"

  require 'yaml'
  puts YAML.dump timeslots

end
