# Phase 4 On Duty

A small Heroku-ready Sinatra application that uses the Trello API to figure out which Phase 4 students are "on duty" and displays them in a web page. The intent is that the Phase 1-3 students always know who to talk to when they need help.

## Development Setup Instructions

You'll need ruby 1.9.3-p327 and the bundler gem installed. It's recommended to use a ruby environment manager like [rbenv] or [rvm].

[rbenv]:https://github.com/sstephenson/rbenv/
[rvm]:https://rvm.io/

You'll also need to [get a Trello API key][tk] and non-expiring token. Once you have the key you can get the token from this url:

    https://trello.com/1/authorize?key=REPLACE_WITH_YOUR_KEY&expiration=never&response_type=token

(Be sure to replace the `REPLACE_WITH_YOUR_KEY` with your own Trello application key)

[tk]:https://trello.com/docs/gettingstarted/index.html#getting-an-application-key

Create a `trello-conf.sh` file that exports your key and token:

    export TRELLO_KEY=YOUR_KEY
    export TRELLO_TOKEN=YOUR_TOKEN

Then run `./server.sh` to start the server.

You can override the board with an environment variable: `TRELLO_BOARD=517a07d3b196882f2a00234b ./sever.sh`

## Deployment

Ensure you're a collaborator on the heroku app then run: `git push heroku master`

The production (heroku) environment uses Myles's API key and token, that doesn't need to change as long as myles is a member of the board.
