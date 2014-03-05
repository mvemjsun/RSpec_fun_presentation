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