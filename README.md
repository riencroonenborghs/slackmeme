# SlackMeme

## Set up

### Server

Clone this repository and set it up on a server somewhere.

Make sure it's accessible from the outside world, because Slack is going to post data to it.

### Slack

Go to your slack account and set up an outgoing webhook, and have it point to your server.

Now, every time something gets posted on the channel you've chosen, a json package is going to be sent to your server.

The magic starts here.