class MemeGenerator
  IMGFLIP_URL = "https://api.imgflip.com/caption_image"

  MEMES = [
    {id: 61579, regexp: /^(one does not simply)(.*)/, name: 'one does not simply _X_', top: false, bottom: true},
    {id: 100947, regexp: /^(what if i told you)(.*)/, name: 'what if i told you _X_', top: false, bottom: true},
    {id: 61546,  regexp: /^(brace yourselves)(.*)/,  name: 'brace yourselves _X_', top: false, bottom: true},
    {id: 16464531, regexp: /^(.*)(but that(?:')?s none of my business)/, name: '_X_ but that\'s none of my business', top: true, bottom: false},
    {id: 61533, regexp: /^(.*)((all the)(.*))/, name: '_X_ all the _Y_', top: true, bottom: false},
    {id: 442575, regexp: /^(.*)(ain(?:')?t nobody got time for that)/, name: '_X_ ain\'t nobody got time for that', top: true, bottom: false},
    {id: 11074754, regexp: /^(.*)(we(?:')?re dealing with a badass over here)/, name: '_X_ we\'re dealing with a badass over here', top: true, bottom: false},
    {id: 766986, regexp: /^(.*?)((a)+nd it(?:')?s gone)\z/, name: '_X_ and it\'s gone', top: true, bottom: false}    
  ]

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
    {image_url: image_url}
  end

private

  def match_memes(message)
    return nil if message.nil?

    MEMES.each do |hash|
      if hash[:regexp] =~ message.downcase
        top = $1; top.strip! if hash[:top]
        bottom = $2; bottom.strip! if hash[:bottom]
        return {id: hash[:id], top: top, bottom: bottom}
      end
    end

    nil
  end
end