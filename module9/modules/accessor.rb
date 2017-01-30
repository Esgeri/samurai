module Accessor
    def attr_accessor_with_history(*attributes)
      attributes.each do |attribute|
        var_attribute = "@#{attribute}".to_sym

        define_method(attribute) {instance_variable_get(var_attribute)}

        define_method("#{attribute}=".to_sym) {|value| instance_variable_set(var_attribute, value)}

        define_method("#{attribute}_history") {instance_variable_get(var_attribute)}

      end
    end

    def strong_attr_accessor(attribute, class_name)
      var_attribute = "@#{attribute}".to_sym

      define_method(attribute) do
        instance_variable_get(var_attribute)
      end

      define_method("#{attribute}=".to_sym) do |value|
        raise 'TypeError' unless value.is_a? class_name
          instance_variable_set(var_attribute, value)
      end
    end
end
