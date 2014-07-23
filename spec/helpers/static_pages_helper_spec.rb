require 'spec_helper'

describe "StaticPagesHelper" do

	describe "Geocoding Imports" do

		describe "with invalid input" do
			
			it "should return nil with empty filepath" do
				empty_geocodes = ImportCSV(" ")
				empty_geocodes.should be_nil
			end

			it " should return nil with nil filepath" do
				nil_geocodes = ImportCSV(nil) 
				nil_geocodes.should be_nil
			end
		end

		describe "with valid file input" do

			it "should contain 102 Geocoded Address" do
				imported_geocodes = ImportCSV(File.join(Rails.root, 
														 'app',
														 'assets', 
														 'csv', 
														 'GeocodeAddresses.csv'))

				expect(imported_geocodes.count).to be(102) 
			end

			it "should chomp newline from csv import" do
				imported_geocodes = ImportCSV(File.join(Rails.root, 
														 'app',
														 'assets', 
														 'csv', 
														 'GeocodeAddresses.csv'))

				expect(imported_geocodes[2].include?("\n")).to be_false
			end

			it "should find RoofTop Addresses" do
				s = GetValidJsonGeoCodedAddress()

				expect(IsRoofTopAddress(s)).to be_true
			end

			it "should get Geocoded Addresses" do
				s = GeocodeAddress('1600 Amphitheatre Parkway, Mountain View, CA')

				expect(s).not_to be_nil
			end

			it "should get Correct GeoCodes" do
				address = GeocodeAddress('9 Ross Haven Way Southeast, Medicine Hat, AB T1B 2T8, Canada')

				lat = JSON.parse(address)['results'][0]['geometry']['location']['lat']
				lng = JSON.parse(address)['results'][0]['geometry']['location']['lng']

				expect(lat).to eq(50.0018813)
				expect(lng).to eq(-110.6368152) 
			end
		end

	end

end
