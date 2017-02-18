class Passenger < Train
  validate :train_name, :presence
  validate :train_name, :format

  def initialize(number, _type)
    super(number, 'passenger')
  end
end
