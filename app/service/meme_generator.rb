class MemeGenerator
  IMGFLIP_URL = "https://api.imgflip.com/caption_image"

  attr_accessor :meme

  def initialize(message)
    @meme = match_memes(message)
  end

  def valid?
    !@meme.nil?
  end

  def generate!
    response = Unirest.post(
      IMGFLIP_URL,
      parameters: {
        username:     ENV['IMGFLIP_USERNAME'],
        password:     ENV['IMGFLIP_PASSWORD'],
        template_id:  meme[:id], 
        text0:        meme[:top], 
        text1:        meme[:bottom]
      }
    )
     
    image_url = response.body['data']['url']
    { image_url: image_url }
  end

private
  
  def match_memes(message)
    return nil if message.nil?

    case message.downcase
    when /^(one does not simply)(.*)/
      return { id: 61579, top: $1, bottom: $2.strip! }
    when /^(what if i told you)(.*)/
      return { id: 100947, top: $1, bottom: $2.strip! }
    when /^(brace yourselves)(.*)/
      return { id: 61546, top: $1, bottom: $2.strip! }
    when /^(.*)(but that(?:')?s none of my business)/
      return { id: 16464531, top: $1.strip!, bottom: $2 }
    when /^(.*)((all the)(.*))/
      return { id: 61533, top: $1.strip!, bottom: $2 }
    when /^(.*)(ain(?:')?t nobody got time for that)/
      return { id: 442575, top: $1.strip!, bottom: $2 }
    when /^(.*)(we(?:')?re dealing with a badass over here)/
      return { id: 11074754, top: $1.strip!, bottom: $2 }
    when /^(.*?)((a)+nd it(?:')?s gone)\z/
      return { id: 766986, top: $1.strip!, bottom: $2 }
    else
      return nil
    end
  end
end