# curl -X POST http://localhost:3000 -d 'message=one does not simply foo abar'
# curl -X POST http://slackmeme.croonenborghs.net -d 'message=one does not simply foo abar'

class MemesController < ApplicationController
  # token=ZX1VbztRNTpBfEiLk5XyMY9B
  # team_id=T0001
  # channel_id=C2147483705
  # channel_name=test
  # timestamp=1355517523.000005
  # user_id=U2147483697
  # user_name=Steve
  # text=googlebot: What is the air-speed velocity of an unladen swallow?
  # trigger_word=googlebot:

  def generate
    message = params[:message]
    service = ::MemeGenerator.new(message)

    if service.valid?
      hash = service.generate!
      SlackWriter.push!(hash[:image_url])
      render json: hash.to_json
    else
      render json: {error: 'not valid'}.to_json
    end
  end
end
