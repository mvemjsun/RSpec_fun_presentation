## Fun with RSpec - Part 2
> Exploring Behaviour-Driven Development with Ruby. Testing what should happen rathen than what will happen.

### In this part
1. we demonstrate Context (same as a describe block)
```ruby
describe "Bank database" do
  context "Initial state" do
```

2. Helper modules to share code
```ruby
module BankHelpers
  def create_and_register_account(account_options)
    account = Account.new({:name => account_options[:name], :balance => account_options[:balance]})
    account.register
    return account
  end
end
[...]
describe "Bank account and bank database" do
  include BankHelpers
[...]
```

3. Custom matchers
```ruby
RSpec::Matchers.define :return_an do |object_type|
  match do |expected_object_type|
    expected_object_type.kind_of?(object_type)
  end
end
[...]
it "should be created successfully" do
  Account.new({:name => "Bill", :balance => 1000}).should return_an(Account)
end
```

4. Expectations
```ruby
expect{Account.new({:name => "James", :balance => -100})}.to raise_error("InvalidAccountOptions")
```

5. Hooks (before(:all) and around(:each))
```ruby
before(:all) do
  @bankDatabase = BankDatabase.database
end
[...]
around(:each) do
  @bankDatabase = BankDatabase.database
  @bankDatabase.reset # TODO -- remove observers
  @account1 = create_and_register_account({:name => "Bill", :balance => 1000})
  @account2 = create_and_register_account({:name => "Hillary", :balance => 2000})
  @account3 = create_and_register_account({:name => "Simon", :balance => 3000})
end
```


### About the code under test

#### `Account` class

The account class models an Account in a bank. This uses the "observer" design pattern by including the `Observable` module.
The account attributes are `@id`,`@name` and `@balance`. The `@id` is a sequence that is held in the BankDatabase class. Each account that is created is added to the database. The database acts as an observer to the account and any changes to the account balance invokes the `update` method on the BankDatabase class.

```ruby
require 'observer'
require_relative 'bankdatabase'

class Account
  include Observable

  attr_reader :balance, :id, :name

  def initialize(options)
    validate_account_options(options)
    @name = options[:name]
    @balance = options[:balance]
    @id = BankDatabase.next_id
    BankDatabase.add_account(self)
    self
  end

  def deposit(amount)
    @balance = @balance + amount
    changed
    notify_observers(self)
    @balance
  end

  def withdraw(amount)
    raise "NotEnoughBalance" if amount > @balance
    @balance = @balance - amount
    changed
    notify_observers(self)
    @balance
  end

  #
  # Register once account is created and added for future events
  #
  def register
    self.add_observer(BankDatabase.database)
  end

  def validate_account_options(options)
    if (options[:name].nil? || 
      options[:name].empty? || 
      options[:balance].nil? || 
       !options[:balance].kind_of?(Numeric) || 
      options[:balance] < 0) 
      raise "InvalidAccountOptions"
    end
  end
end
```

#### `BankDatabase` class

This class acts as the 'bank's database' and is the observer to the Account. Its a singleton class and returns an instance
to `self` using the BankDatabase.database call. Its `update` method is used to update the account attributes.

```ruby
class BankDatabase

  @@id_counter # Current max account id
  @@accounts   # All the accounts, ie our database !

  def self.database
    @@id_counter ||= 0
    @@accounts ||= {}
    self
  end

  def self.next_id
    @@id_counter ||= 0
    @@id_counter += 1
  end

  def self.get_account_details(id)
    raise "AccountNotFound" unless @@accounts[id]
    @@accounts[id]
  end

  def self.current_id
    @@id_counter
  end

  def self.account_count
    @@accounts.size
  end

  def self.add_account(account)
    @@accounts[account.id] = {:balance => account.balance, :name => account.name}
  end

  def self.update(account)
    @@accounts[account.id] = {:balance => account.balance, :name => account.name}
  end

  def self.reset
    @@id_counter = 0
    @@accounts = {}
    self
  end

  private_class_method :new
end
```

### Output with documentation
When we run `rake test:part2` we get
```
Bank database
  Initial state
    when set to initial state should have no accounts
    when set to initial state should have current max customer id set to 0
    should provide way to add an account
    should provide way to update an account
    should provide way to get account details
    should raise Account not found exception when we search for an unknown account

Bank account
  Invalid account attributes
    with no account attributes should raise error InvalidAccountOptions
    with no account name should raise error InvalidAccountOptions
    with no account balance should raise error InvalidAccountOptions
    with negative balance should raise error InvalidAccountOptions
  With valid account attributes
    should be created successfully

Bank account and bank database
  Should successfully create and store account
    When 3 bank accounts are created then the database account count should be 3

    Account id 1 balance should be 1000
    Account id 2 name should be Hillary
  Depositing money into account
    should increase account balance
    should update database balance
  Withdrawing money from account
    Should reduce account balance
    Should raise error NotEnoughBalance when insufficient balance

Finished in 0.12502 seconds
18 examples, 0 failures
```
### Next
[Goto Part 3] (https://github.com/mvemjsun/RSpec_fun/blob/master/README_Part_3.md)

### Further info at
1. [RSpec] (https://www.relishapp.com/rspec/rspec-core/v/3-0/docs)