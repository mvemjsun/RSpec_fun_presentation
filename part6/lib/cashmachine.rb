class CashMachine

	# dispence only in multiples of 5
	def dispense(amount=0)
		return 0 unless amount%5 == 0
		amount
	end
end