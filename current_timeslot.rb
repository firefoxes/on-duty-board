# Tells us whether a given timeslot name the one happening right now

require 'time' # provides Time.parse

# First version by github/shivamd

module CurrentTimeslot

  extend self

  def is_current_timeslot?(timeslot, current_time = Time.now)
    parse_time_boundaries(timeslot).cover?(current_time)
  rescue ArgumentError, TypeError
    false
  end

  def is?(ts, ct = Time.now)
    is_current_timeslot? ts, ct
  end

  def parse_time_boundaries(timeslot)
    begin_time, end_time = Time.parse(timeslot[/.+-/]), Time.parse(timeslot[/-.+/])
    (begin_time..end_time)
  end

end

if $0 == __FILE__

  include CurrentTimeslot

  now = Time.parse "12:25pm"
  tests = [
    is_current_timeslot?("11:30am - 1 pm",          now),
  ! is_current_timeslot?("Lecture: 10am - 11:30am", now),
    is_current_timeslot?("Lecture: 12pm - 1:30pm",  now),
    is_current_timeslot?("Lecture: 12:25pm - 1pm",  now),
  ! is_current_timeslot?("1pm",                     now),
  ! is_current_timeslot?("No time info",            now)
  ]

  if tests.all? then puts ':)' else abort ':(' end

end
