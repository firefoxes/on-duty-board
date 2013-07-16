# A mock version of the Timeslot data source

require 'hashugar'
require 'yaml'

require './current_timeslot'

module MockTimeslots

  extend self

  DATA = YAML.load File.read(__FILE__).split(/^__END__/, 2).last

  def load
    DATA.
      map { |slot_data| Hashugar.new slot_data }.
      each { |slot| slot[:current?] = true if CurrentTimeslot.is? slot.name }
  end

end

# ---

if $0 == __FILE__

  require 'pp'
  pp MockTimeslots.load

end

# ---

__END__
---
- name: 9 am - 11 am
  members:
  - full_name: Vincent Storme
    avatar_url: https://trello-avatars.s3.amazonaws.com/9cbf8ad08ecac4b9c020fbc16f67399c/170.png
  - full_name: Chris
    avatar_url: https://trello-avatars.s3.amazonaws.com/a9fe976d520e4c7d434c7e43ffa2fea7/170.png
  - full_name: Sidney Zhang
    avatar_url: https://trello-avatars.s3.amazonaws.com/6aaa6350306c0b7ef42a1925ccaa1be3/170.png
- name: ! 'LECTURE: 11 am - 1 pm'
  members: []
- name: 1 pm - 3 pm
  members:
  - full_name: Sean Miller
    avatar_url: https://trello-avatars.s3.amazonaws.com/e4182237243de5fe0c7129a572cd4486/170.png
  - full_name: pat scanlan
    avatar_url: https://trello-avatars.s3.amazonaws.com/d8725600f8b93dcf63639a5c1aa26ee1/170.png
  - full_name: Sidney Zhang
    avatar_url: https://trello-avatars.s3.amazonaws.com/6aaa6350306c0b7ef42a1925ccaa1be3/170.png
  - full_name: Fab Mackojc
    avatar_url: https://trello-avatars.s3.amazonaws.com/373eff060707227bfac8333e242ca6db/170.png
- name: 3 pm - 6 pm
  members:
  - full_name: Robby Fairclough
    avatar_url: https://trello-avatars.s3.amazonaws.com/f2ecbb1912945019043888485bd23e2e/170.png
  - full_name: Chris
    avatar_url: https://trello-avatars.s3.amazonaws.com/a9fe976d520e4c7d434c7e43ffa2fea7/170.png
  - full_name: Avalon Emerson
    avatar_url: https://trello-avatars.s3.amazonaws.com/3384c3ccbd9f7d095ebbfa358cbb9cb6/170.png
- name: 6 pm - 9 pm
  members:
  - full_name: Sam Samskies
    avatar_url: https://trello-avatars.s3.amazonaws.com/1c3f6ebdad862645d32c45adbf9733b5/170.png
