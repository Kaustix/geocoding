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
		end

	end

end
