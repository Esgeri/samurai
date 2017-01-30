class Wagoon
  include Manufacturer
  extend Accessor
  extend Validation

  attr_reader :type, :wagoon
  # attr_accessor_with_history :color
  # strong_attr_accessor :title, String

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
    raise 'Тип вагона имеет не правильный формат!' if type !~ Train::TRAIN_TYPE
  end
end
