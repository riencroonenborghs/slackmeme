require 'rails_helper'

describe SlackWriter do

  before(:each) do
    ENV['SLACK_INCOMING_HOOK'] = 'SLACK_INCOMING_HOOK'
    ENV['SLACK_CHANNEL'] = 'SLACK_CHANNEL'
  end

  context 'self#push!' do
    it "should return if message is nil" do
      expect(SlackWriter.push!(nil)).to eq nil
    end
    it "should post" do
      expect(Unirest).to receive(:post)
      SlackWriter.push!('message')
    end
    it "should post to channel" do
      expect(Unirest).to receive(:post).with(/(.+)/, parameters: /\"channel\": \"#SLACK_CHANNEL\"/)
      SlackWriter.push!('message')
    end
    it "should post username" do
      expect(Unirest).to receive(:post).with(/(.+)/, parameters: /\"username\": \"SlackMeme\"/)
      SlackWriter.push!('message')
    end
    it "should post message" do
      expect(Unirest).to receive(:post).with(/(.+)/, parameters: /\"text\": \"message\"/)
      SlackWriter.push!('message')
    end
    it "should post to URL" do
      expect(Unirest).to receive(:post).with('SLACK_INCOMING_HOOK', parameters: /(.+)/)
      SlackWriter.push!('message')
    end
  end

end