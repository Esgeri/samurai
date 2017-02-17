module Accessor
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*attributes)
      attributes.each do |attribute|
        var_attribute = "@#{attribute}".to_sym

        define_method(attribute) do
          instance_variable_get(var_attribute)
        end

        define_method("#{attribute}=") do |value|
          instance_variable_set(var_attribute, value)
          @history ||= {}
          @history[var_attribute] ||= []
          @history[var_attribute] << value
        end

        define_method("#{attribute}_history".to_sym) do
          @history ? @history[var_attribute] : []
        end
      end
    end
  end

  module InstanceMethods
    def strong_attr_accessor(attribute, class_name)
      var_attribute = "@#{attribute}".to_sym

      define_method(attribute) do
        instance_variable_get(var_attribute)
      end

      define_method("#{attribute}.to_s") do |value|
        raise TypeError, 'Не соответствие типа!' if value.class != class_name
        instance_variable_set(var_attribute, value)
      end
    end
  end
end
