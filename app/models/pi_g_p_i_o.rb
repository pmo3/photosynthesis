class PiGPIO
  ACTIVE_PINS = [2]
  NUMBERING = :bcm.freeze

  def initialize
    gpio_config = YAML.load(File.read('config/gpio.yml'))
    @gpio = gpio_config[Sinatra::Base.environment.to_s].constantize
  end

  def pins
    raise "You must set the active pins in app/models/pi_g_p_i_o.rb. This should be a list of pins on your pi that are connected to your lights" unless ACTIVE_PINS
    Array(ACTIVE_PINS)
  end

  def numbering
    NUMBERING
  end

  def lights_on?
    pins.each do |pin|
      return false unless light_on? pin
    end
    true
  end

  def lumos
    pins.each do |pin|
      @gpio.set_low pin
      return false unless light_on? pin
    end
    true
  end

  def nox
    pins.each do |pin|
      @gpio.set_high pin
      return false if light_on? pin
    end
    true
  end

  private

  def light_on?(pin)
    @gpio.low? pin
  end
end
