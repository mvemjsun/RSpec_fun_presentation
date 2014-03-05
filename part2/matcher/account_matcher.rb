RSpec::Matchers.define :return_an do |object_type|
	match do |expected_object_type|
		expected_object_type.kind_of?(object_type)
	end
end

RSpec::Matchers.define :change_balance_to do |expected_balance|
	match do |actual_balance|
		expected_balance == actual_balance
	end
end
