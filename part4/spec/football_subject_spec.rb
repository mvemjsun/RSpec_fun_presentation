require_relative '../lib/FootballTeam'

#
# Explicit subject
#
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

#
# implicit Subject
#
describe FootballTeam  do
	
	it {should be_empty}

end