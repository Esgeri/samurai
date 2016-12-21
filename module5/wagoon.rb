class Wagoon
  include ManufacturerName
  attr_reader :type

  def initialize(type)
    @type = type
  end
end
