require 'rails_helper'

describe MemesController, type: :controller do

  let(:params) { {message: "meme all the memes"} }

  before(:each) do
    allow(SlackWriter).to receive(:push!).and_return(nil)
  end

  context 'POST #generate' do
    it "should be success" do
      post :generate, params
      expect(response).to be_success
    end

    it "should render nothing" do
      post :generate, params
      expect(response.body).to eq ' '
    end
  end

end