## Fun with RSpec - Part 7
> Exploring Behaviour-Driven Development with Ruby. Testing what should happen rathen than what will happen.

### In this part

1. we demonstrate how to expect consecutive values from a method call.

Here we are expecting the call to `lunch_break` method 3 times to invoke `eat_meal` each time which will return account balances of 7,4,1 each time a meal is consumed (Assuming an initial balance of $10 and that each meal costs $3).

```ruby
@mealaccount.should_receive(:eat_meal).and_return(7,4,1)
[...]
3.times {@mealaccount.lunch_break}
```

```ruby
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
```

### About the code under test

#### `SchoolmealAccount` class
A very important SchoomealAccount class that feeds hungry minds !

```ruby
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
```

### Output with documentation
When we run `rake test:part6` we get
```
School meal account with $10
  when consuming meals
    account balance should be 7 when one meal is eaten
    account balance should be 4 when two meals are eaten
    account balance should be 1 when 3 meals have been consumed
  when insufficient funds available
    account should raise NotEnoughFunds error when insufficient funds

Finished in 0.021 seconds
4 examples, 0 failures
```

### Next
[Start again] (https://github.com/mvemjsun/RSpec_fun/blob/master/README.md)

### Further info at
1. [RSpec] (https://www.relishapp.com/rspec/rspec-core/v/3-0/docs)