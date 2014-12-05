require 'rails_helper'

describe MemesController, type: :controller do

  let(:params) { {text: "meme all the memes", trigger_word: 'slackmeme:'} }
  let(:image_url) { 'image_url' }

  before(:each) do
    ENV['SLACK_INCOMING_TRIGGER_WORD'] = 'slackmeme:'
    allow_any_instance_of(MessageHandler).to receive(:process!).and_return({image_url: image_url})
  end

  context 'POST #generate' do
    it "should be success" do
      post :generate, params
      expect(response).to be_success
    end

    it "should render json image_url" do
      post :generate, params
      expect(response.body).to eq '{"image_url":"image_url"}'
    end

    it "should render json trigger word error" do
      post :generate, params.merge(trigger_word: 'trigger_word')
      expect(response.body).to eq '{"error":"invalid trigger_word"}'
    end
  end

  context 'GET #list' do
    it 'should be success' do
      get :list
      expect(response).to be_success
    end
    it 'should render' do
      get :list
      expect(response).to render_template(:list)
    end
  end

end