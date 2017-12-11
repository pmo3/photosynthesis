# require 'spec_helper'
#
# RSpec.feature 'Sign in Process', type: :feature do
#
#   before(:each) do
#     @user = FactoryBot.create(:user)
#   end
#
#   describe 'signing in' do
#     it 'lets me log in' do
#       visit '/'
#       page.assert_selector('#username')
#       fill_in 'Username', with: @user.username
#       fill_in 'password', with: @user.password
#       click 'Submit'
#       expect(current_path).to eq('/')
#     end
#   end
# end
