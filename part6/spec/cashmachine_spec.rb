require_relative '../lib/cashmachine'
require_relative '../matcher/custom'

describe "Cashmachine" do

	before(:each) do
		@cashMachine = CashMachine.new
	end

	it "should dispense money in multiples of 5" do
		@cashMachine.should_receive(:dispense).with(MoneyMatcher.amount_in_multiple_of_5)
		@cashMachine.dispense(10)
	   #@cashMachine.dispense(14)
# Failures:

#   1) Cashmachine should dispense money in multiples of 5
#      Failure/Error: @cashMachine.dispense(14)
#        #<CashMachine:0x2c50d70> received :dispense with unexpected arguments
#          expected: (amount that is multiple of 5)
#               got: (14)
#      # ./spec/cashmachine_spec.rb:13:in `block (2 levels) in <top (required)>'
	end
end