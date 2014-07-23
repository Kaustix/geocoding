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

	def GetGeoCodedAddresses(fileName)
		addressArray = ImportCSV(fileName)

		results = []

		addressArray.each do |address|
			geoAddress = GeocodeAddress(address)
			if (IsRoofTopAddress(geoAddress))
				results << Geocode.new(address, 
									   GetLatitude(geoAddress), 
									   GetLongitude(geoAddress))
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
		return nil if address.blank?

		jsonAddress = JSON.parse(address)

		begin
			return (jsonAddress['results'][0]['geometry']['location_type'] == "ROOFTOP")
		rescue
			return false
		end			
	end

	def GetLatitude(geocode)
		return nil if geocode.blank?

		jsonAddress = JSON.parse(geocode)
		return jsonAddress['results'][0]['geometry']['location']['lat']
	end

	def GetLongitude(geocode)
		return nil if geocode.blank?

		jsonAddress = JSON.parse(geocode)
		return jsonAddress['results'][0]['geometry']['location']['lng']
	end

end
