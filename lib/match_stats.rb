module HoN
	class MatchStats < Stats
		def initialize(match_id)
			@match_id = match_id
			@summary_stats = Hash.new
			@team_one_stats = Hash.new
			@team_two_stats = Hash.new
			@team_one_players = []
			@team_two_players = []
			begin
				url = "http://xml.heroesofnewerth.com/xml_requester.php?f=match_stats&opt=mid&mid[]=#{@match_id}"
				xml_data = Net::HTTP.get_response(URI.parse(url)).body
				data = REXML::Document.new(xml_data)
				data.elements.each('/xmlRequest/stats/match/summ/stat') do |stat|
					@summary_stats[stat.attributes["name"]] = stat.text
				end
				data.elements.each("/xmlRequest/stats/match/team[@side=1]/stat") do |stat|
					@team_one_stats[stat.attributes["name"]] = stat.text
				end
				data.elements.each("/xmlRequest/stats/match/team[@side=2]/stat") do |stat|
					@team_two_stats[stat.attributes["name"]] = stat.text
				end
				data.elements.each("/xmlRequest/stats/match/match_stats/ms") do |ms|
					temp = Hash.new
					team = 0
					ms.elements.each do |stat|
						if stat.attributes["name"] == "team"
							team = Integer(stat.text)
						end
							
						temp[stat.attributes["name"]] = stat.text
					end
					if team == 1
						@team_one_players.push(temp)
					else
						@team_two_players.push(temp)
					end
				end
			rescue SocketError
				@error = "Could not contact the Newerth XML API."
			end
		end
		def team_one
			@team_one_players
		end
		def team_two
			@team_two_players
		end
		def match_id 
			if defined? @match_id
				@match_id
			else
				nil
			end
		end
		def summary_stats(key)
			if @summary_stats.has_key? key
				@summary_stats[key]
			else
				return 0
			end
		end
		def team_one_stats(key)
			if @team_one_stats.has_key? key
				@team_one_stats[key]
			else
				return 0
			end
		end
		def team_two_stats(key)
			if @team_two_stats.has_key? key
				@team_two_stats[key]
			else
				return 0
			end
		end
		def dump_xml_stats
			return @summary_stats, @team_one_stats, @team_two_stats, @team_one_players
		end
	end
end