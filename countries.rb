require "normalize_country"

puts $_.rstrip + "\t" + (NormalizeCountry($_) || "")
