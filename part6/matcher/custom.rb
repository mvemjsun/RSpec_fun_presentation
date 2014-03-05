class MoneyMatcher

	def ==(amount)
		amount%5 == 0
	end

	def self.amount_in_multiple_of_5
		MoneyMatcher.new
	end

	def description
		"amount that is multiple of 5"
	end
end