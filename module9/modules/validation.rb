module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :params

    def validate(name, type, option = nil)
      self.params ||= []
      params << { name: name, type: type, option: option }
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
        value = instance_variable_get("@#{param[:name]}")
        method = "#{param[:type]}.to_s"
        send(method, value, param[:option])
      end
    end
  end

  private

  def valid_presence(attribute)
    raise ArgumentError, 'Значение не должно быть пустым!' if attribute.nil? || attribute.eql?('')
  end

  def valid_format(attribute, format)
    raise ArgumentError, 'Значение не соответствует формату!' if attribute !~ format
  end

  def valid_type(attribute, type)
    raise TypeError, 'Не соответствие типа!' unless attribute.is_a?(type)
  end
end
