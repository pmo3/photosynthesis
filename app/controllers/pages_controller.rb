class PagesController < ApplicationController

  get "/" do
    erb :"pages/index"
  end
end
