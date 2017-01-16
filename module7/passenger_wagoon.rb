class Passenger_wagoon < Wagoon
  attr_accessor :place_count, :empty_place

  def initialize(wagoon, place_count)
    @wagoon = wagoon
    super(wagoon, "passenger")
    @place_count = place_count
    @busy_place = 0
  end

  def take_place
    @busy_place += 1
  end

  def show_busy_place
    @busy_place
  end

  def show_free_place
    @place_count - @busy_place
  end

  def to_s
    "Номер вагона #{@wagoon}, занятые места #{show_busy_place}, свободные места #{show_free_place}"
  end
end
