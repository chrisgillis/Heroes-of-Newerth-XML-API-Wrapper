module HoN
	class PlayerStats < Stats
		def initialize(nickname)
			@nickname = nickname
			@stats = Hash.new
			begin
				url = "http://xml.heroesofnewerth.com/xml_requester.php?f=player_stats&opt=nick&nick[]=#{@nickname}"
				xml_data = Net::HTTP.get_response(URI.parse(url)).body
				data = REXML::Document.new(xml_data)
				data.elements.each('/xmlRequest/stats/player_stats/stat') do |stat|
					@stats[stat.attributes["name"]] = stat.text
				end
			rescue SocketError
				@error = "Could not contact the Newerth XML API."
			end
		end
	end
end