require 'spec_helper'

RSpec.describe AuthController, type: :controller do

  context 'login' do
    describe "GET login" do
      it 'responds with status 200' do
        get '/login'
        expect(last_response.status).to eq 200
      end
    end

  end
end
