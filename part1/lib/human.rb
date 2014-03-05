class HumanBeing

	attr_accessor :age
	attr_reader :type, :name, :gender

	def initialize(options)

		@age = options[:age] if options[:age]

		if options[:age]
			@type = case @age
					when (0..2)
						:baby
					when (3..5)
						:toddler
					when (6..12)
						:child
					when (13..19)
						:teenager
					when @age > 19
						:adult
					end	
		end

		@name = options[:name] if options[:name]
		@gender = options[:gender] if options[:gender]
	end

	def greet
		case @age
		when (0..2)
			"Waa"
		when (3..5)
			"DadaMama"
		when (6..12)
			"Hiya"
		when (13..19)
			"HiDude"
		when @age > 19
			"Hello"
		end
	end

	def push
		case @age
		when (0..2)
			"Cry"
		when (3..5)
			"Scream"
		when (6..12)
			"Pushback"
		when (13..19)
			"Swear"
		else
			"Falldown"
		end
	end

	def favourite_colour
		case @gender

		when "male"
			"any thing but pink"
		when "female"
			"pink"
		end
	end

	def to_s
		"#{@name} : #{@age} : #{@gender} : #{@type}.to_s"
	end
end