require_relative '../lib/FootballTeam'
require 'debugger'

describe "Football team" do

	before(:each) do
		@players = ["JEFFERSON","DANI ALVES","THIAGO SILVA","DAVID LUIZ","FERNANDO",
				   "MARCELO","LUCAS","HERNANES","FRED","NEYMAR","OSCAR"
				  ]
		@team = FootballTeam.new
		@players.each do |player|
			@team.add_player(player)
		end
	end

	it "should have 11 players" do
		@team.should have(11).players
	end

	it "should have 9 players when 2 players are injured" do
		@team.injure("OSCAR")
		@team.injure("FERNANDO")
		@team.should have(9).players
	end

	it "should have raise error when 12th player is added" do
		expect {
			@team.add_player("RONALDO")
		}.to raise_error("TeamFull")
	end

	it "should have 11 players when we try to add more than 11 players" do
		begin
			@team.add_player("RONALDO")
		rescue => e
			e.message.should == "TeamFull"
		ensure
			@team.should have_exactly(11).players
		end
	end

	# be predicate matcher
	it "should not be full if a player is injured" do
		@team.injure("DANI ALVES")
		@team.should_not be_full
	end

	it "should be full if there are 11 players" do
		@team.should be_full
	end
end