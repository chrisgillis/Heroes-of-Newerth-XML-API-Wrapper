# A wrapper for the Heroes of Newerth XML API
# -------------------------------------------
# Author: Chris Gillis
# -------------------------------------------
#
# A list of variables for stat() can be found on the xml.heroesofnewerth.com
# website by running the relevant example query
#
# DEPENDENCIES
#   Requires rubygems
#            rexml
#
# USAGE:
#   require 'hon'
#   @my_stats = HoN::PlayerStats.new("account_name")
#   puts @my_stats.stat("acc_games_played")
#   @match = HoN::MatchStats.new("match_id")
#   puts @match.team_one
#   puts @match.team_two
#   puts @match.summary_stats("time_played")
#   puts @match.team_one_stats("tm_losses")


module HoN
	require 'net/http'
	require 'rubygems'
	require 'rexml/document'
	require 'lib/stats.rb'
	require 'lib/playerstats.rb'
	require 'lib/matchstats.rb'
end