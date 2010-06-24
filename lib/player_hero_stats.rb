module HoN
	class PlayerHeroStats < Stats
		def initialize(nickname)
			@nickname = nickname
			@heroes = Hash.new
			begin
				url = "http://xml.heroesofnewerth.com/xml_requester.php?f=player_hero_stats&opt=nick&nick[]=#{@nickname}"
				xml_data = Net::HTTP.get_response(URI.parse(url)).body
				data = REXML::Document.new(xml_data)
				data.elements.each("/xmlRequest/stats/player_hero_stats/hero") do |hero|
					temp = Hash.new
					hero.elements.each do |stat|
						temp[stat.attributes["name"]] = stat.text
					end
					@heroes.store(hero.attributes["cli_name"], temp)
				end
			rescue SocketError
				@error = "Could not contact the Newerth XML API."
			end
		end
		
		def nickname
			@nickname
		end
		
		def heroes
			@heroes
		end
		
		def stats(hero,key)
			if !hero.empty?
				if @heroes.has_key? hero
					if @heroes[hero].has_key? key
						@heroes[hero][key]
					end
				end
			else
				return 0
			end
		end
		
		def dump_xml_stats
			return @heroes
		end
	end
end