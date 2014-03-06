## Fun with RSpec - Part 1
> Exploring Behaviour-Driven Development with Ruby. Testing what should happen rathen than what will happen.

### In this part
1. we demonstrate ExampleGroup

An example group is a collection of tests.

```ruby
describe "A Human being" do
```

2. Example

An example is an executable test.

```ruby
it "should have name, age, type and gender" 
```

3. Nested groups

Nested groups help to better organise the tests, we can group tests that are similar under groups or contexts.

```ruby
describe "A Human being" do
 ...
   describe "has age related behaviour" do
```

4. `Before(:all)` hook

Hooks are used when we want to run some code before, after each example. There are also hooks that can be run once. Similarly we have hooks that can be run around each example.

```ruby
before(:all) do
	@baby = HumanBeing.new(options={:age => 2, :name => "James", :gender => "male"})
end
```

### About the code under test

#### `HumanBeing` class

A ver simple Human being that can `greet`, `push` and responds to `favourite_colour`.
Changes behaviour with age !

```ruby
class HumanBeing

  attr_accessor :age
  attr_reader :type, :name, :gender

  def initialize(options)

    @age = options[:age] if options[:age]

    if options[:age]
      @type = case @age
          when (0..2)
            :baby
          when (3..5)
            :toddler
          when (6..12)
            :child
          when (13..19)
            :teenager
          when @age > 19
            :adult
          end 
    end

    @name = options[:name] if options[:name]
    @gender = options[:gender] if options[:gender]
  end

  def greet
    case @age
    when (0..2)
      "Waa"
    when (3..5)
      "DadaMama"
    when (6..12)
      "Hiya"
    when (13..19)
      "HiDude"
    when @age > 19
      "Hello"
    end
  end

  def push
    case @age
    when (0..2)
      "Cry"
    when (3..5)
      "Scream"
    when (6..12)
      "Pushback"
    when (13..19)
      "Swear"
    else
      "Falldown"
    end
  end

  def favourite_colour
    case @gender

    when "male"
      "any thing but pink"
    when "female"
      "pink"
    end
  end

  def to_s
    "#{@name} : #{@age} : #{@gender} : #{@type}.to_s"
  end
end
```


### Output with documentation
When we run `rake test:part1` we get
```
A Human being
  should have name, age, type and gender
  has age related behaviour
    Baby
      should Waa when greeted
      should Cry when pushed
    Teenager
      should respond with HiDude when greeted
      should Swear when pushed
  gender behaviour for colour
    males dont like pink
    females like pink
    
Finished in 0.018 seconds
7 examples, 0 failures
```

### Further info at
1. [RSpec] (https://www.relishapp.com/rspec/rspec-core/v/3-0/docs)