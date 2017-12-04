require 'spec_helper'

RSpec.describe PagesController do

  describe "GET index" do
    it 'responds with status 200' do
      get '/'
      expect(last_response.status).to eq 200
    end
  end
end
