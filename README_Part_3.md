## Fun with RSpec - Part 3
> Exploring Behaviour-Driven Development with Ruby. Testing what should happen rathen than what will happen.

### In this part
1. we demonstrate have(n) matchers (same as a describe block)
```ruby
@team.should have(9).players
[...]
@team.should have_exactly(11).players
[...]
```

### About the code under test

#### `FootballTeam` class

The class is a simple class that models a football team. It uses the `Set` class to implement a unique set or players
in the team.

```ruby
require 'enumerator'
require 'set'

class FootballTeam
  include Enumerable

  def initialize(players=nil)
    if players.nil?
      @team = Set.new
    else
      players.each do |player|
        @team.add player.downcase
      end
    end
  end

  def add_player(player)
    raise "TeamFull" if team_size == 11   
    @team << player unless team_size > 11
  end

  def injure(player)
    raise "TeamEmpty" if team_size == 0
    raise "PlayerNotFound" unless @team.include? player   
    @team.delete player if team_size > 0
  end

  def each
    @team.each {|player| yield player}
  end

  def length
    @team.length if @team
  end

  def reset_team
    @team.clear
  end

  def team_size
    length
  end

  def full?
    return true if team_size == 11
    return false unless team_size == 11
  end

  #
  # could also be a syntactic sugar in which case the should
  # invokes the length or size method
  #
  def players
    @team
  end

  def size
    @team.length if @team
  end
end
```

#### How the `have` matcher works

When we say `@team.should have(9).players` there are a few things that happen behind the scene in RSpec. The `have(9)` method
returns an instance of `Have` which is like saying `Have.new` and set the value of the have object to 9.

Next ruby tries to send the `players` method to the `have` object, but since it does not have a `players` method it invokes the
`method_missing` of `have` and stores the message (`players` in this case) for later use.

Ruby next passes the result of `have(9).players` to `should` which sends `matches?(self)` to the matcher.

Next Ruby checks to see if `@team` responds to the method that was stored in method_missing (`players` in our case), if so it expects it to return a type of collection object. If this is the case then ruby checks if the collect responds to `length` or `size`, if this is the case then this is compared to the actual size from `have`.

If the `@team` object does not respond to the method stored in method_missing, then ruby looks if it can respond to `length` or `size`
, if so then the result of `length ` or `size` is compared against the output from `have(9).players`.

In the code for the 'FootballTeam' class we have included the `players` method which returns the collection `@team`. Even if we commented this method the tests would still pass as ruby will invoke the `length` or the `size` method which return the size of `@team` .

```ruby
class FootballTeam
  [...]
  def length
    @team.length if @team
  end
  [...]
  def players
    @team
  end
  [...]
end
```

2. we demonstrate the "be_" matcher

```ruby
@team.should_not be_full
[...]
@team.should be_full
```
#### How the `be_` matcher works

RSpec strips the `be_` and invokes the `full` appended with a `?` . In our case it is similar to `@team.full?.should == true`.

### Output with documentation
When we run `rake test:part3` we get
```
Football team
  should have 11 players
  should have 9 players when 2 players are injured
  should have raise error when 12th player is added
  should have 11 players when we try to add more than 11 players
  should not be full if a player is injured
  should be full if there are 11 players

Finished in 0.049 seconds
6 examples, 0 failures
```

### Next
[Goto Part 4] (https://github.com/mvemjsun/RSpec_fun/blob/master/README_Part_4.md)

### Further info at
1. [RSpec] (https://www.relishapp.com/rspec/rspec-core/v/3-0/docs)