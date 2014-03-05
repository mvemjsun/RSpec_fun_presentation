#
# Demonstrated the use of mocking to test code that is under development
#
require_relative '../lib/car'

#
# Add method stubs named indicate_left and indicate_right to the car object
#
describe "A car" do
	before(:each) do
		@car = Car.new({:make => "Ford", :model => "Fiesta", :cc => "1.2", :fuel => "Petrol"})
		@car.stub(:indicate_left).and_return(:left)
		@car.stub(:indicate_right).and_return(:right)
		@car.stub(:brake)
	end

	it "should indicate left when turned left" do
		@car.turn({:direction => :left}).should == :left
	end

	it "should indicate right when turned right" do
		@car.turn({:direction => :right}).should == :right
	end

	it "should be able to stop" do
		@car.should_receive(:stop).and_return(0)
		@car.slow_down(0)
		@car.speed.should == 0
	end
end

#
# method stub with expectation, expecting that the slow_down method should invoke brake
#
describe "Use brakes" do
	before(:each) do
		@car = Car.new({:make => "Ford", :model => "Fiesta", :cc => "1.2", :fuel => "Petrol"})
		@car.stub(:brake).and_return(30)
		@car.should_receive(:brake).and_return(30)
	end

	it "Car should use brakes when slowed down" do
		@car.slow_down(30)
	end
end

#
# method implementation injection, here we create a gear double and then inject a method "change_to" 
# into the gear object 
#
describe "Gear" do

	before(:each) do
		@gear = double("gear")
		@gear.stub(:change_to) do |number|
			case number
			when (1..4)
				number
			when -1
				"R"
			end
		end		
		@car = Car.new({:make => "Vauxhall", :model => "Corsa", :cc => "1.4", :fuel => "Petrol", :gear => @gear})
	end

	it "car should be able to change gear" do
		@car.gear.change_to(1).should == 1
		@car.gear.change_to(2).should == 2
		@car.gear.change_to(3).should == 3
		@car.gear.change_to(-1).should == "R"
	end
end