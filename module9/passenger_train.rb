class Passenger < Train
  validate :number, :valid_presence
  validate :number, :valid_format, :NUMBER_FORMAT

  def initialize(number, _type)
    super(number, 'passenger')
  end
end
