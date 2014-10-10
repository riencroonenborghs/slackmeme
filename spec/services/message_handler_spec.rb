require 'rails_helper'

describe MessageHandler do

  let(:message) { "meme all the memes" }

  context '#new' do
    it "should raise execption" do
      expect { MessageHandler.new }.to raise_exception
    end
    it "should raise not execption" do
      expect { MessageHandler.new(message) }.to_not raise_exception
    end
  end

  context '#process!' do
    it "should handle list" do
      expect_any_instance_of(MessageHandler).to receive(:handle_list)
      MessageHandler.new('return the list please').process!
    end
    it "should handle meme" do
      expect_any_instance_of(MessageHandler).to receive(:handle_meme)
      MessageHandler.new(message).process!
    end
  end

  context '#handle_meme' do
    context 'success' do
      before(:each) do
        allow(SlackWriter).to receive(:push!)      
        allow_any_instance_of(MemeGenerator).to receive(:valid?).and_return(true)      
        allow_any_instance_of(MemeGenerator).to receive(:generate!).and_return({image_url: 'image_url'})
      end
      it "should return" do
        expect(MessageHandler.new(message).send(:handle_meme)).to_not eq nil
      end
      it "should return hash" do
        expect(MessageHandler.new(message).send(:handle_meme).class).to eq Hash
      end
      it "should return image_url" do
        hash = {image_url: 'image_url'}
        expect(MessageHandler.new(message).send(:handle_meme)).to eq hash
      end
      it "should push to slack" do
        expect(SlackWriter).to receive(:push!)      
        MessageHandler.new(message).send(:handle_meme)
      end
    end

    it "should return invalid meme error" do
      hash = {error: 'invalid meme'}
      expect(MessageHandler.new('message').send(:handle_meme)).to eq hash
    end
  end


  context '#handle_list' do
    let(:message) { 'gimme the list' }

    before(:each) do
      allow(SlackWriter).to receive(:push!)      
    end
    
    it "should return" do
      expect(MessageHandler.new(message).send(:handle_list)).to_not eq nil
    end
    it "should return hash" do
      expect(MessageHandler.new(message).send(:handle_list).class).to eq Hash
    end
    it "should return all memes" do
      hash = {:memes=>["one does not simply _X_", "what if i told you _X_", "brace yourselves _X_", "_X_ but that's none of my business", "_X_ all the _Y_", "_X_ ain't nobody got time for that", "_X_ we're dealing with a badass over here", "_X_ and it's gone"]}
      expect(MessageHandler.new(message).send(:handle_list)).to eq hash
    end
  end

end