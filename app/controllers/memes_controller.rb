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
      render json: {foo: :bar}.to_json
    else
      render nothing: true
    end
  end
end
