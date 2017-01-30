module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :params

    def validate(attribute, type, option = nil)
      @params ||= [] << {attribute: attribute, type: type, option: option}
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue
      false
    end

    def validate!
      self.class.params.each do |param|
        if param[:type] == :presence
          valid_presence(param[:attribute])
        elsif param[:type] == :format
          valid_format(param[:attribute], param[:option])
        elsif param[:type] == :type
          valid_type(param[:attribute], param[:option])
        end
      end
    end
  end

protected
  def valid_presence(attribute)
    raise "Пустое значение" if attribute.nil? || attribute.eql?('')
  end

  def valid_format(attribute, format)
    raise "Формат не валидный" unless attribute =~ format
  end

  def valid_type(attribute, type)
    raise "Неправильный тип" unless attribute.is_a?(type)
  end

end
