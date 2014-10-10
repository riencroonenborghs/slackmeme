class MessageHandler
  attr_accessor :message

  def initialize(message)
    @message = message
  end

  def process!
    if parsed_message =~ /list/
      handle_list
    else
      handle_meme
    end
  end

private

  def parsed_message
    @parsed_message ||= @message.gsub(/^#{ENV['SLACK_INCOMING_TRIGGER_WORD']} /,'')
  end

  def handle_list
    names = MemeGenerator::MEMES.map{|x| x[:name]}
    SlackWriter.push!(names.join('\n'))
    {memes: names}
  end

  def handle_meme
    generator = ::MemeGenerator.new(parsed_message)
    if generator.valid?
      hash = generator.generate!
      SlackWriter.push!(hash[:image_url])      
      hash
    else
      {error: 'invalid meme'}
    end
  end

end