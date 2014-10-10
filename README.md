# SlackMeme

## Credits

Got the idea from this post: [How to Build a Meme Generator Using Twilio MMS, Imgflip and Sinatra](https://www.twilio.com/blog/2014/10/how-to-build-a-meme-generator-using-twilio-mms-imgflip-and-sinatra.html?utm_source=rubyweekly&utm_medium=email).

## Set up

### Server

Clone this repository and set it up on a server somewhere.

Make sure it's accessible from the outside world, because Slack is going to post data to it.

#### Imgflip

[Imgflip](https://imgflip.com/) lets you generate memes. Simple as that. Sign up, you'll need it.

Put your credentials in .env

```
IMGFLIP_USERNAME=username
IMGFLIP_PASSWORD=itsasecret
```


### Slack

Go to your Slack account and set up an outgoing webhook, and have it point to your server. Use a trigger word. Also set up an incoming webhook for the channel you want. Put the incoming webhook URL, trigger word and channel in your .env

```
SLACK_INCOMING_HOOK=slackurl
SLACK_INCOMING_TRIGGER_WORD=slackmeme:
SLACK_CHANNEL=channel
```

## How it works

Every time something gets posted on the channel you've chosen in your outgoing webhook, a json package is going to be sent to your server. The magic starts here. The app will listen to certain keywords. Based on that it will talk to Imgflip to generate a meme, and post the result back to Slack through the incoming webhook.

Simple as that.

Have fun!