require_relative '../lib/schoolmealaccount'

describe "School meal account with $10" do

	context "when consuming meals" do
		before(:each) do
			@mealaccount = SchoolmealAccount.new({:name => "Ella",:balance => 10,:each_meal_cost => 3})
		end

		it "account balance should be 7 when one meal is eaten" do
			@mealaccount.should_receive(:eat_meal).and_return(7)
			@mealaccount.lunch_break
		end
		it "account balance should be 4 when two meals are eaten" do
			@mealaccount.should_receive(:eat_meal).and_return(7,4)
			2.times {@mealaccount.lunch_break}
		end
		it "account balance should be 1 when 3 meals have been consumed" do
			@mealaccount.should_receive(:eat_meal).and_return(7,4,1)
			3.times {@mealaccount.lunch_break}
		end
	end

	context "when insufficient funds available" do
		before(:each) do
			@error = double(RuntimeError.new("NotEnoughFunds"))
			@mealaccount = SchoolmealAccount.new({:name => "Ella",:balance => 10,:each_meal_cost => 3})
			3.times {@mealaccount.lunch_break}
		end

		it "account should raise NotEnoughFunds error when insufficient funds" do
			expect {@mealaccount.lunch_break}.to raise_error("NotEnoughFunds")
		end
	end
end