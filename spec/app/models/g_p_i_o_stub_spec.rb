require 'spec_helper'

RSpec.describe GPIOStub, type: :model do

  subject { GPIOStub.new }

  context 'sanity check that required methods exist' do
    before do
      @methods = [
        :set_numbering,
        :setup,
        :high?,
        :low?,
        :set_low,
        :set_high,
        :clean_up
      ]
    end

    it 'includes required methods' do
      @methods.each do |method|
        expect(subject).to respond_to(method)
      end
    end
  end # sanity check

# check that these methods only accept expected inputs like the real thing
  context 'method inputs' do
    context 'set_numbering' do
      it 'accepts :bcm' do
        expect(subject.set_numbering(:board)).to be true
      end

      it 'accepts :board' do
        expect(subject.set_numbering(:bcm)).to be true
      end

      it 'does not accept other symbols' do
        expect(subject.set_numbering(:board_and_bcm)).to be false
      end

      it 'does not accept strings' do
        expect(subject.set_numbering('board')).to be false
      end
    end # set_numbering

    context 'setup' do
      it 'accepts an integer and a hash with an :as option' do
        expect(subject.setup(1, as: :input)).to be true
      end

      it 'accepts :input for :as' do
        expect(subject.setup(1, as: :input)).to be true
      end

      it 'accepts :output for :as' do
        expect(subject.setup(1, as: :output)).to be true
      end

      it 'does not accept other options for :as' do
        expect(subject.setup(1, as: :something)).to be false
      end

      it 'does not accept other input types for pin_num' do
        expect(subject.setup("1", as: :input)).to be false
      end
    end # setup

    context 'high?' do
      it 'accepts an integer as input' do
        expect(subject.high? 2).to be true
      end

      it 'does not accept another type as input' do
        expect(subject.high? Hash.new).to be false
      end
    end # high?

    context 'low?' do
      it 'accepts an integer as input' do
        expect(subject.low? 2).to be true
      end

      it 'does not accept another type as input' do
        expect(subject.low? Hash.new).to be false
      end
    end # low?

    context 'set_high' do
      it 'accepts an integer as input' do
        expect(subject.set_high 2).to be true
      end

      it 'does not accept another type as input' do
        expect(subject.set_high Hash.new).to be false
      end
    end # set_high

    context 'set_low' do
      it 'accepts an integer as input' do
        expect(subject.set_low 2).to be true
      end

      it 'does not accept another type as input' do
        expect(subject.set_low "2").to be false
      end
    end # set_low
  end
end
