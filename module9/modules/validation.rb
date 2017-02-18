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
    rescue StandartError
      false
    end

    def validate!
      self.class.params.each do |param|
        value = instance_variable_get("@#{param[:name]}")
        method = "#{param[:type]}"
        send(method, value, param[:option])
      end
    end

    private

    def presence(name, value)
      raise 'Значение не должно быть пустым!' if name.nil? || name.eql?('')
      true
    end

    def format(name, format)
      raise "Значение не соответствует формату!" unless name =~ format
      true
    end

    def type(name, type)
      raise "Не соответствие типа!" unless name.is_a?(type)
      true
    end
  end
end
