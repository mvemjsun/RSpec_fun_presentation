## Fun with RSpec - Part 6
> Exploring Behaviour-Driven Development with Ruby. Testing what should happen rathen than what will happen.

### In this part

1. we demonstrate how custom argument matcher works

A custom argument matcher is needed when we need to test specific rules against the arguments of a method. For example we want to
be sure that a cash dispenser receives withdraw amounts that are in multiples of $5.

```ruby
@cashMachine.should_receive(:dispense).with(MoneyMatcher.amount_in_multiple_of_5)
```

In this case all we need to do is that the argument to `with()` is an object that implement a specific interface that follows the
below rules.
  * implement a `==` method
  * optionally implement a `describe` method
  * optionally implement a user friendly method to invoke that returns an instance of this matcher class.

```ruby
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
```

### About the code under test

#### `CashMachine` class
A CashMachine class that is under development !

```ruby
class CashMachine

  # dispence only in multiples of 5
  def dispense(amount=0)
    return 0 unless amount%5 == 0
    amount
  end
end
```

### Output with documentation
When we run `rake test:part6` we get
```
Cashmachine
  should dispense money in multiples of 5

Finished in 0.005 seconds
1 example, 0 failures
```

in case we try `@cashMachine.dispense(14)` in the tests we will get.
```
Failures:

  1) Cashmachine should dispense money in multiples of 5
     Failure/Error: @cashMachine.dispense(14)
       #<CashMachine:0x2c50d70> received :dispense with unexpected arguments
         expected: (amount that is multiple of 5)
              got: (14)
     # ./spec/cashmachine_spec.rb:13:in `block (2 levels) in <top (required)>'
```
### Next
[Goto Part 7] (https://github.com/mvemjsun/RSpec_fun/blob/master/README_Part_7.md)

### Further info at
1. [RSpec] (https://www.relishapp.com/rspec/rspec-core/v/3-0/docs)