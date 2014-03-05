require_relative '../lib/human'

describe "A Human being" do

	it "should have name, age, type and gender" do
		humanBeing = HumanBeing.new({})
		expect(humanBeing).to respond_to(:name)
		expect(humanBeing).to respond_to(:age)
		expect(humanBeing).to respond_to(:type)
		expect(humanBeing).to respond_to(:gender)
	end

	describe "has age related behaviour" do

		context "Baby" do
			before(:all) do
				@baby = HumanBeing.new(options={:age => 2, :name => "James", :gender => "male"})
			end

			it "should Waa when greeted" do
				expect(@baby.greet).to eq("Waa")
			end
			it "should Cry when pushed" do
				expect(@baby.push).to eq("Cry")
			end
		end

		context "Teenager" do
			before(:all) do
				@teen = HumanBeing.new(options={:age => 16, :name => "Charlie", :gender => "male"})
			end

			it "should respond with HiDude when greeted" do
				expect(@teen.greet).to eq("HiDude")
			end
			it "should Swear when pushed" do
				expect(@teen.push).to eq("Swear")
			end
		end		
	end

	describe "gender behaviour for colour" do

		it "males dont like pink" do
			male = HumanBeing.new(options={:age => 32, :name => "David", :gender => "male"})
			expect(male.favourite_colour).to eq "any thing but pink"
		end

		it "females like pink" do
			female = HumanBeing.new(options={:age => 39, :name => "Sarah", :gender => "female"})
			expect(female.favourite_colour).to eq "pink"
		end		
	end
end