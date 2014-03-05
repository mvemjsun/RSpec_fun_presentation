#
# A Car class that is being built
#
class Car

	attr_reader :speed, :make, :model, :cc, :fuel
	
	def initialize(options)
		@make = options[:make]
		@model = options[:model]
		@cc = options[:cc]
		@fuel = options[:fuel]
		@speed = 0
		#
		# Composition with gear box
		#
		@gear = options[:gear] if options[:gear]
	end

	def speed_up(speed)
		@speed = speed
	end

	def gear
		@gear if @gear
	end

	def to_s
		"#{@make} / #{@model} / #{@cc} / #{@fuel}"
	end

	def stop
		brake
		@speed = 0
	end

	def slow_down(speed)
		brake
		@speed = speed
		stop if speed == 0
	end

	def turn(direction)
		case 
		when direction[:direction] == :left
			indicate_left
		when direction[:direction] == :right
			indicate_right
		end
	end
end