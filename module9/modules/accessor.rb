module Accessor
  def self.included(base)
    base.extend(InstanceMethods)
  end

  class InstanceMethods
    def attr_accessor_with_history(*attributes)
      attributes.each do |attribute|
        var_attribute = "@#{attribute}".to_sym

        define_method(attribute) { instance_variable_get(var_attribute) }

        define_method("#{attribute}=".to_sym) { |value| instance_variable_set(var_attribute, value) }
      end
    end

    def strong_attr_accessor(attribute, class)
      var_attribute = "@#{attribute}".to_sym

      define_method(attribute) do
        instance_variable_get(var_attribute)
      end

      define_method("#{attribute}") do |value|
        raise "Значение не является не требуемым типом #{type}" if !value.is_a?(type)
        instance_variable_set(var_attribute, value)
      end
    end
  end
end
