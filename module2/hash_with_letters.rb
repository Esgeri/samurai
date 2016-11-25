alphabet = "a".."z"

vowels = %w[ a e i o u]

vowel_hash = {}

alphabet.each_with_index do |key, value|  
  if vowels.include?(key)
    vowel_hash[key] = value + 1
  end
end

puts vowel_hash