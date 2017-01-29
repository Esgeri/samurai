module Validation
  def validate(validation_name, validation_format, validation_type)
    validation_name = "@#{validation_name}".to_s

    if validation_name == :presence
      instance_variable_get(validation_name).nil?
    elsif validation_format == :format
      instance_variable_get(validation_format) =~ /A-Z{0,3}/
    elsif validation_type == :type
      instance_variable_get(validation_type).station, :type, Station
    end
  end

  def validate!
    p 'validate!'
  end

  def valid?
    p 'valid?'
  end
end
