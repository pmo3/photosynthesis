require 'spec_helper'

RSpec.describe PiGPIO, type: :model do

  subject { PiGPIO.new }

  it 'raises an error if ACTIVE_PINS not set' do
    expect{subject.pins}.to raise_error("You must set the active pins in app/models/pi_g_p_i_o.rb. This should be a list of pins on your pi that are connected to your lights")
  end
end
