#!/usr/bin/env ruby

require 'gosu'

# Usage example: $ ./parser.rb /Path/to/logfile/log.txt

# Here's an array of strings that we'll be searching for in a text file
pattern = ["HISTORY", "BQ::", "BLC::", "MW::"]

# Define a hash.  Keys are the search terms, and values are the noise we want to play if the string is found
$noises = {
	"HISTORY" => "./assets/soundclips/51__koen__distorted-guitar-chords/822__koen__gd-emch0.wav",
 	"BQ::" => "./assets/soundclips/3__plagasul__weird-male-screams-pack/79__plagasul__long-scream.wav",
 	"BLC::" => "./assets/soundclips/41__elmomo__exprsynths/715__elmomo__rstfinalexprr.mp3",
 	"MW::" => "./assets/soundclips/17__tictacshutup__studio-drums-1/442__tictacshutup__prac-snare-rimshot-2.wav"
 	}

#make some gosu sample objects from our noises so we can play them back later
$gosu_noises = {}
$noises.map {|k, v|  $gosu_noises[k] = Gosu::Sample.new(v)}

# Basically, tail a file
def parse(file, pattern)
  f = File.open(file,"r")
  f.seek(0,IO::SEEK_END)
  # loop-de-loop
  while true do
  	# grab each line from the end of the file as it appears
    line = f.gets
    # Assumes "pattern" is an array of strings.  
    # For each element in the array
    pattern.each {|x|
    	# check and see if it's found in the line
    	# If the element is found, put the value from the noises hash
    	puts x if /#{x}/ =~ line
      #and make the corresponding noise with gosu
      $gosu_noises[x].play if /#{x}/ =~ line
    }
  end
end

# Call the method!  The first and only argument should be the path to the logfile you want to watch
parse(ARGV[0], pattern)