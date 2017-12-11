class PiGPIO
  ACTIVE_PINS = nil
  NUMBERING = :board.freeze

  def initialize
    gpio_config = YAML.load(File.read('config/gpio.yml'))
    @gpio = gpio_config[Sinatra::Base.environment.to_s].constantize
  end

  def pins
    raise "You must set the active pins in app/models/pi_g_p_i_o.rb. This should be a list of pins on your pi that are connected to your lights" unless ACTIVE_PINS
  end

  def numbering
    NUMBERING
  end

  def lights_on?

  end
end
