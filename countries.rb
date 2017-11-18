require "normalize_country"

# Run this like:
#     cat countries.txt | ruby -n countries.rb

puts $_.rstrip + "\t" + (NormalizeCountry($_) || "")
