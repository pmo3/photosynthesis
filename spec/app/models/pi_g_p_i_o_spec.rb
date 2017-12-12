require 'spec_helper'

RSpec.describe PiGPIO, type: :model do

  subject { PiGPIO.new }

  it 'raises an error if ACTIVE_PINS not set' do
    stub_const("PiGPIO::ACTIVE_PINS", nil)
    expect{subject.pins}.to raise_error("You must set the active pins in app/models/pi_g_p_i_o.rb. This should be a list of pins on your pi that are connected to your lights")
  end

  it 'sets the numbering to board' do
    expect(subject.numbering).to eq(:bcm)
  end

  context '#lights_on?' do
    before do
      @pins = [2, 3, 4, 5]
      stub_const("PiGPIO::ACTIVE_PINS", @pins)
    end

    it 'returns true if all lights are on' do
      expect(subject.lights_on?).to be true
    end

    it 'returns false if a light is off' do
      allow(GPIOStub).to receive(:low?).and_return(false)
      expect(subject.lights_on?).to be false
    end
  end # lights_on?

  context '#lumos' do
    before do
      @pins = [2, 3, 4, 5]
      stub_const("PiGPIO::ACTIVE_PINS", @pins)
    end

    it 'sets each pin to low' do
      expect(GPIOStub).to receive(:set_low).exactly(@pins.count).times
      subject.lumos
    end

    it 'returns true if all lights are on' do
      expect(subject.lumos).to be true
    end

    it 'returns false if one of the pins is not on' do
      allow_any_instance_of(PiGPIO).to receive(:light_on?).and_return false
      expect(subject.lumos).to be false
    end
  end # lumos

  context '#now' do
    before do
      @pins = [2, 3, 4, 5]
      stub_const("PiGPIO::ACTIVE_PINS", @pins)
    end

    it 'sets each pin to high' do
      allow_any_instance_of(PiGPIO).to receive(:light_on?).and_return false
      expect(GPIOStub).to receive(:set_high).exactly(@pins.count).times
      subject.nox
    end

    it 'returns true if all lights are off' do
      allow_any_instance_of(PiGPIO).to receive(:light_on?).and_return false
      expect(subject.nox).to be true
    end

    it 'returns false if one of the pins is not off' do
      allow_any_instance_of(PiGPIO).to receive(:light_on?).and_return true
      expect(subject.nox).to be false
    end
  end # now
end
