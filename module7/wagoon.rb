class Wagoon
  include Manufacturer
  attr_reader :type, :wagoon

  def initialize(wagoon, type)
    @type = type
    @wagoon = wagoon
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  protected
  def validate!
    raise "Тип вагона имеет не правильный формат!" if type !~ Train::TRAIN_TYPE
  end
end
