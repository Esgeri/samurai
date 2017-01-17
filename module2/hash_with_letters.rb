alphabet = 'a'..'z'

vowels = %w(a e i o u)

vowel_hash = {}

alphabet.each_with_index do |key, value|
  vowel_hash[key] = value + 1 if vowels.include?(key)
end

puts vowel_hash
