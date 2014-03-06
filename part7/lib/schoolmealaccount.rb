class SchoolmealAccount

	attr_reader :balance
	#
	# A Simple school meal account that is initialised with a name and balance
	# and the cost of the meal for the account
	def initialize(options)
		@name = options[:name]
		@balance = options[:balance]
		@meal_cost = options[:each_meal_cost]
	end

	#
	# every time a meal is eaten the balance is reduced by 3
	#
	def eat_meal
		raise "NotEnoughFunds" if @balance < @meal_cost
		@balance = balance - @meal_cost
	end

	def lunch_break
		eat_meal
	end

	#
	# top up the account
	#
	def top_up(amount)
		@balance = @balance + amount if @amount > 0
		@balance
	end
end