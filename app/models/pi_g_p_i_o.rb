class PiGPIO
  ACTIVE_PINS = nil

  def pins
    raise "You must set the active pins in app/models/pi_g_p_i_o.rb. This should be a list of pins on your pi that are connected to your lights" unless ACTIVE_PINS
  end
end
