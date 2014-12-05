require 'rails_helper'

describe ImgFlip::Generator do

  let(:message) { "One Does Not Simply|line1|line2" }

  context '#new' do
    it "should raise execption" do
      expect { ImgFlip::Generator.new }.to raise_exception
    end
    it "should raise not execption" do
      expect { ImgFlip::Generator.new(message) }.to_not raise_exception
    end
    it "should parse message" do
      allow_any_instance_of(ImgFlip::Generator).to receive(:parse_message)
      ImgFlip::Generator.new(message)
    end
  end

  context '#valid?' do
    it "should return true" do
      expect(ImgFlip::Generator.new(message).valid?).to eq true
    end
    it "should return false" do
      expect(ImgFlip::Generator.new('message').valid?).to eq false
    end
  end

  context '#generate!' do
    before(:each) do
      response = Struct.new(:body).new({'data' => {'url' => 'some-url'}})
      allow(Unirest).to receive(:post).and_return(response)
    end

    it "should return" do
      expect(ImgFlip::Generator.new(message).generate!).to_not eq nil
    end

    it "should return hash" do
      expect(ImgFlip::Generator.new(message).generate!.class).to eq Hash
    end

    it "should return url" do
      hash = {image_url: 'some-url'}
      expect(ImgFlip::Generator.new(message).generate!).to eq hash
    end
  end

  context '#parse_message' do
    it "should return when message is nil" do
      expect_any_instance_of(ImgFlip::Generator).to receive(:parse_message).and_return(nil)
      ImgFlip::Generator.new(nil)
    end
    it "should return when no memes was found" do
      expect(ImgFlip::Generator.new(nil).send(:parse_message, 'message')).to eq nil
    end 
    it "should return" do
      expect(ImgFlip::Generator.new(nil).send(:parse_message, message)).to_not eq nil
    end
    it "should return meme model" do
      meme = ImgFlip::Generator.new(nil).send(:parse_message, message)
      expect(meme.class).to eq ImgFlip::Meme
      expect(meme.id).to eq '61579'
    end
  end

end