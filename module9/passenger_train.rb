class Passenger < Train
  validate :number, :presence
  validate :number, :format, :NUMBER_FORMAT

  def initialize(number, _type)
    super(number, 'passenger')
  end
end
