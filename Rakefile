require 'rspec/core/rake_task'

namespace :test do

	task :all => [:part1, :part2,:part3, :part4, :part5, :part6]

	RSpec::Core::RakeTask.new(:part1) do |t|
		Dir.chdir(File.dirname(__FILE__) + "/part1")
		t.rspec_opts = "-f d"
	end

	RSpec::Core::RakeTask.new(:part2) do |t|
		Dir.chdir(File.dirname(__FILE__) + "/part2")
		t.rspec_opts = "-f d"
	end

	RSpec::Core::RakeTask.new(:part3) do |t|
		Dir.chdir(File.dirname(__FILE__) + "/part3")
		t.rspec_opts = "-f d"
	end

	RSpec::Core::RakeTask.new(:part4) do |t|
		Dir.chdir(File.dirname(__FILE__) + "/part4")
		t.rspec_opts = "-f d"
	end

	RSpec::Core::RakeTask.new(:part5) do |t|
		Dir.chdir(File.dirname(__FILE__) + "/part5")
		t.rspec_opts = "-f d"
	end

	RSpec::Core::RakeTask.new(:part6) do |t|
		Dir.chdir(File.dirname(__FILE__) + "/part6")
		t.rspec_opts = "-f d"
	end	
end