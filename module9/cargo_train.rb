class Cargo < Train
  validate :train_name, :presence
  validate :train_name, :format

  def initialize(number, _type)
    super(number, 'cargo')
  end
end
