module BankHelpers
	def create_and_register_account(account_options)
		account = Account.new({:name => account_options[:name], :balance => account_options[:balance]})
		account.register
		return account
	end
end