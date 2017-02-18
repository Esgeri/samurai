class Cargo_wagoon < Wagoon
  attr_accessor :general_volume, :loaded_volume

  def initialize(wagoon, general_volume)
    super(wagoon, 'cargo')
    @general_volume = general_volume
    @loaded_volume = 0
  end

  def set_volume(load_volume)
    @loaded_volume += load_volume if @loaded_volume < @general_volume
  end

  def show_loaded_volume
    @loaded_volume
  end

  def show_free_volume
    @general_volume - @loaded_volume
  end
end
