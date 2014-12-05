class MemesController < ApplicationController
  def generate
    if params[:trigger_word] != ENV['SLACK_INCOMING_TRIGGER_WORD']
      render json: {error: 'invalid trigger_word'}.to_json
      return
    end

    handler = ::MessageHandler.new(params[:text])
    response = handler.process!

    render json: response.to_json
  end

  def list
    @memes = MEME_DATABASE.memes
  end
end