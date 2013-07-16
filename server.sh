# load local trello conf if it exists
test -f trello-conf.sh && source trello-conf.sh
# ensure port set
export PORT=${PORT-4000}
# ensure board set
export TRELLO_BOARD=${TRELLO_BOARD-51ace06d8e03d65713003fcf}
# ensure the timezone is set
export TZ=${TZ-"America/Los_Angeles"}
# start the server in the right gem environment
exec bundle exec ruby server.rb -p $PORT
