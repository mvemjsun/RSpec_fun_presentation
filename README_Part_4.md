## Fun with RSpec - Part 4
> Exploring Behaviour-Driven Development with Ruby. Testing what should happen rathen than what will happen.

### In this part
1. we demonstrate implicit and explicit subject

```ruby
describe FootballTeam  do
  
  before(:each) do
    @players = ["JEFFERSON","DANI ALVES","THIAGO SILVA","DAVID LUIZ","FERNANDO",
         "MARCELO","LUCAS","HERNANES","FRED","NEYMAR","OSCAR"
        ]
  end

  subject {
    @footballteam = FootballTeam.new(@players)
  }

  it {should have(11).players}
end
```

An implicit subject is created when we explicitly invoke the `subject` method in an example group. After this any calls to `should` or 
`should_not` are delegated to the subject. 

```ruby
describe FootballTeam  do
  it {should be_empty}
end
```
In the above case `FootballTeam` is the implicit subject whose object is created by `FootballTeam.new` when the example is run. The call to should is then delated to a newly created instance of FootballTeam. It should be noted that for this to work elegantly 
`FootballTeam.new` or any other implicit subject should be set to the current state.

### About the code under test

#### `FootballTeam` class

The class is a simple class that models a football team. It uses the `Set` class to implement a unique set or players
in the team.

```ruby
require 'enumerator'
require 'set'

class FootballTeam
  include Enumerable

  def initialize(players=[])
    if players.nil?
      @team = Set.new
    else
      @team = Set.new
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
    return @team.length if @team
    return 0 unless @team
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

  def empty?
    return true if team_size == 0
    return false unless team_size == 0
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


### Output with documentation
When we run `rake test:part3` we get
```

```

### Further info at
1. [RSpec] (https://www.relishapp.com/rspec/rspec-core/v/3-0/docs)