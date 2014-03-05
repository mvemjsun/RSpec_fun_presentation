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