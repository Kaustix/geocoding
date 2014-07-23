require 'net/http'
require 'uri'
require 'json'

module StaticPagesHelper
	def ImportCSV(filename)
		return nil if filename.blank?

		results = []

		File.read(filename).each_line do |line|
			results << line.chomp
		end

		return results
	end

	def GetGeoCodedAddresses(addressArray)
		results = []

		addressArray.each do |address|
			geoAddress = GeocodeAddress(address)
			if (IsRoofTopAddress(geoAddress))
				results << geoAddress
			end
		end

		return results
	end
	
	def GeocodeAddress(address)
		encoded_url = URI.encode("http://maps.googleapis.com/maps/api/geocode/json?address=#{address}&sensor=false")
		uri = URI.parse(encoded_url)
		response = Net::HTTP.get(uri)
	end

	def IsRoofTopAddress(address)
		jsonAddress = JSON.parse(address)

		return (jsonAddress['results'][0]['geometry']['location_type'].to_s == "ROOFTOP")
	end

end
