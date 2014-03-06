## Fun with RSpec - Part 5
> Exploring Behaviour-Driven Development with Ruby. Testing what should happen rathen than what will happen.

### In this part
Mocking objects are needed when we are doing the tests while the real code is still being developed. The `double` method 
helps to create a test double and can represent any object. It can receive an optional string and a hash of key value pairs that get
translated to stubs.
Stubs can be added to objects using the `stub` method, `and_return` methods sets the return value of the stub we create.

1. we demonstrate how mocking works with the `stub` method

```ruby
@car.stub(:indicate_left).and_return(:left)
```

We can test for message expectations. The below code sets the expectation that our example should be able to invoke the `brake` method.
That is when the car slows down brakes should have be applied.

2. How message expectation works

It is worth noting tha message expectation increases the coupling between the test and the code and should be used with care. They
should be used for very specific test conditions.

```ruby
@car.should_receive(:brake).and_return(30)
[...]
it "Car should use brakes when slowed down" do
  @car.slow_down(30)
end
```

in case the slow_down method does not use `brake` we will get
```
 Failures:

   1) Use brakes slows down when brakes used
      Failure/Error: @car.should_receive(:brake).and_return(30)
        (Ford / Fiesta / 1.2 / Petrol).brake(any args)
            expected: 1 time with any arguments
            received: 0 times with any arguments
      # ./spec/car_spec.rb:27:in `block (2 levels) in <top (required)>'
```

3. How method injection can work

```ruby
describe "Car" do

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
  [...]
```

### About the code under test

#### `Car` class
A car class that is under development

```ruby
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
```

### Output with documentation
When we run `rake test:part5` we get
```
A car
  should indicate left when turned left
  should indicate right when turned right
  should be able to stop

Use brakes
  Car should use brakes when slowed down

Gear
  car should be able to change gear

Finished in 0.005 seconds
5 examples, 0 failures
```
### Next
[Goto Part 6] (https://github.com/mvemjsun/RSpec_fun/blob/master/README_Part_6.md)

### Further info at
1. [RSpec] (https://www.relishapp.com/rspec/rspec-core/v/3-0/docs)