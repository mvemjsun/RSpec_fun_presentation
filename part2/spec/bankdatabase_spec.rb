require_relative '../lib/account'
require_relative '../lib/bankdatabase'
require_relative '../matcher/account_matcher'
require_relative '../helper/bank_helpers'
require 'debugger'

describe "Bank database" do

	context "Initial state" do
		before(:all) do
			@bankDatabase = BankDatabase.database
		end

		it "when set to initial state should have no accounts" do
			@bankDatabase.account_count.should eql(0)
		end

		it "when set to initial state should have current max customer id set to 0" do
			@bankDatabase.current_id.should eql(0)
		end

		it "should provide way to add an account" do
			expect(@bankDatabase).to respond_to(:add_account)
		end

		it "should provide way to update an account" do
			expect(@bankDatabase).to respond_to(:update)
		end

		it "should provide way to get account details" do
			expect(@bankDatabase).to respond_to(:get_account_details)
		end

		it "should raise Account not found exception when we search for an account" do
			expect {
				@bankDatabase.get_account_details(1)
			}.to raise_error("AccountNotFound")
		end
	end
end

describe "Bank account" do
	
	context "Invalid account attributes" do
		before(:all) do
			@bankDatabase = BankDatabase.database
		end

		it "with no account attributes should raise error InvalidAccountOptions" do
			expect{Account.new({})}.to raise_error("InvalidAccountOptions")
		end

		it "with no account name should raise error InvalidAccountOptions" do
			expect{Account.new({:name => "", :balance => 100})}.to raise_error("InvalidAccountOptions")
		end

		it "with no account balance should raise error InvalidAccountOptions" do
			expect{Account.new({:name => "James", :balance => nil})}.to raise_error("InvalidAccountOptions")
		end

		it "with negative balance should raise error InvalidAccountOptions" do
			expect{Account.new({:name => "James", :balance => -100})}.to raise_error("InvalidAccountOptions")
		end

	end

	context "With valid account attributes" do
		it "should be created successfully" do
			Account.new({:name => "Bill", :balance => 1000}).should return_an(Account)
		end
	end
end

#
# Share code with use of helper modules
#
describe "Bank account and bank database" do
	include BankHelpers

	around(:each) do
		@bankDatabase = BankDatabase.database
		@bankDatabase.reset # TODO -- remove observers
		@account1 = create_and_register_account({:name => "Bill", :balance => 1000})
		@account2 = create_and_register_account({:name => "Hillary", :balance => 2000})
		@account3 = create_and_register_account({:name => "Simon", :balance => 3000})
	end

	context "Should successfully create and store account" do
		it "When 3 bank accounts are created then the database account count should be 3" do
			@bankDatabase.account_count.should == 3
		end

		it "Account id 1 balance should be 1000" do
			acc1 = @bankDatabase.get_account_details(1)
			acc1[:balance].should == 1000
		end

		it "Account id 2 name should be Hillary" do
			acc1 = @bankDatabase.get_account_details(2)
			acc1[:name].should == "Hillary"
		end
	end

	#
	# Deposit money
	#
	context "Depositing money into account" do
		it "should increase account balance" do
			@account1.deposit(200).should change_balance_to(1200)
		end

		it "should update database balance" do
			acc1_details = @bankDatabase.get_account_details(1)
			acc1_details[:balance].should == 1200
		end
	end

	#
	# withdraw money
	#
	context "Withdrawing money from account" do
		it "Should reduce account balance" do
			@account2.withdraw(500).should change_balance_to(1500)
		end

		it "Should raise error NotEnoughBalance when insufficient balance" do
			expect{@account2.withdraw(1501)}.to raise_error("NotEnoughBalance")
		end
	end

end