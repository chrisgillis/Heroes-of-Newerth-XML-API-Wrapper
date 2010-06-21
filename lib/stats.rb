module HoN
	class Stats
		def nickname
			if @stats.has_key? "nickname"
				@stats["nickname"]
			else
				"Unknown"
			end
		end
		
		def stat(key)
			if @stats.has_key? key
				@stats[key]
			else
				return 0
			end
		end
		
		def dump_xml_stats
			@stats
		end
		
		def error?
			if defined? @error
				true
			else
				false
			end
		end
		
		def error
			@error
		end
	end
end