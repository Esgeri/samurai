require_relative 'modules/accessor'

class Test
  extend Accessor

  attr_accessor_with_history :parameter_a, :parameter_b, :parameter_c
  strong_attr_accessor :attribute, :class_name
end
