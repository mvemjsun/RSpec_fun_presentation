require_relative 'account'
require_relative 'bankdatabase'
require 'debugger'

database = BankDatabase.database
account1 = Account.new(options={:name => "Puneet", :balance => 1000})
account1.add_observer(database)
account2 = Account.new(options={:name => "Sunil", :balance => 2000})
account2.add_observer(database)
account3 = Account.new(options={:name => "James", :balance => 3000})
account3.add_observer(database)
account4 = Account.new(options={:name => "Sheela", :balance => 4000})
account4.add_observer(database)
debugger
p "hello"