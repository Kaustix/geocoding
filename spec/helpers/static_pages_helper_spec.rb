require 'spec_helper'

describe "StaticPagesHelper" do

	describe "Geocoding Imports" do

		describe "empty filepath should retun nil" do
			let(:empty_geocodes) { helper.ImportCSV(" ") }
			subject {empty_geocodes}
			it { should be_nil }
		end

		describe "nil filepath should retun nil" do
			let(:nil_geocodes) { helper.ImportCSV(nil) }
			subject {nil_geocodes}
			it { should be_nil }
		end

		describe "it should contain 101 Geocoded Address" do
			let(:imported_geocodes) { helper.ImportCSV(File.join(Rails.root, 
																 'app', 
																 'csv', 
																 'GeocodeAddresses.csv'))}

			subject {imported_geocodes}

			it { should have(101).items}
		end

	end

end
