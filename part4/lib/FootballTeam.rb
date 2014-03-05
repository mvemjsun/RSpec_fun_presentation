require 'enumerator'
require 'set'

class FootballTeam
	include Enumerable

	def initialize(players=[])
		if players.nil?
			@team = Set.new
		else
			@team = Set.new
			players.each do |player|
				@team.add player.downcase
			end
		end
	end

	def add_player(player)
		raise "TeamFull" if team_size == 11		
		@team << player unless team_size > 11
	end

	def injure(player)
		raise "TeamEmpty" if team_size == 0
		raise "PlayerNotFound" unless @team.include? player		
		@team.delete player if team_size > 0
	end

	def each
		@team.each {|player| yield player}
	end

	def length
		return @team.length if @team
		return 0 unless @team
	end

	def reset_team
		@team.clear
	end

	def team_size
		length
	end

	def full?
		return true if team_size == 11
		return false unless team_size == 11
	end

	def empty?
		return true if team_size == 0
		return false unless team_size == 0
	end

	#
	# could also be a syntactic sugar in which case the should
	# invokes the length or size method
	#
	def players
		@team
	end

	def size
		@team.length if @team
	end
end