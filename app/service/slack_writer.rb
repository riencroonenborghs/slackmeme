class SlackWriter
  def self.push!(message)
    return unless message
    payload = 'payload={"channel": "#'+ENV['SLACK_CHANNEL']+'", "username": "SlackMeme", "text": "'+message+'"}'
    Unirest.post(ENV['SLACK_INCOMING_HOOK'], parameters: payload)
  end
end