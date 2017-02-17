class Wagoon
  include Validation

  attr_reader :type, :wagoon

  def initialize(wagoon, type)
    @type = type
    @wagoon = wagoon
    # validate!
  end
end
