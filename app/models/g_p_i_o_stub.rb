=begin
Because RPi::GPIO can only be installed/run on a raspberry pi Im going to stub out the methods that I need here for test/development, and supply this class where needed in those environments, and supply the real RPi::GPIO class in production

METHODS REQUIRED:
  set_numbering
  setup
  high? (off?)
  low? (on?)
  set_low
  set_high
  clean_up
=end

class GPIOStub

  def self.set_numbering(type)
    type.is_a?(Symbol) && [:bcm, :board].include?(type)
  end

  def self.setup(pin_num, type)
    pin_num.is_a?(Integer) && type.is_a?(Hash) && [:input, :output].include?(type[:as])
  end

  def self.high?(pin_num)
    pin_num.is_a? Integer
  end

  def self.low?(pin_num)
    pin_num.is_a? Integer
  end

  def self.set_low(pin_num)
    pin_num.is_a? Integer
  end

  def self.set_high(pin_num)
    pin_num.is_a? Integer
  end

  def self.clean_up
    true
  end
end
