year = {
	:january => 31,
	:february => 29,
	:march => 31,
	:april => 30,
	:may => 31,
	:june => 30,
	:july => 31,
	:augest => 31,
	:september => 30,
	:october => 30,
	:november => 30,
	:december => 31
}

day = 30

year.each do |key, value|
	# puts key, value
	puts "The months of the year, when the days equals to 30: #{key} - #{value} " if day == value
end
