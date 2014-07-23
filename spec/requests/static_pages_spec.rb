require 'spec_helper'

describe "StaticPages" do

	describe "Geocode page" do

		it "should have title 'Geocode Addresses" do
			visit root_path
			expect(page).to have_title('Geocode Addresses')
		end

		it "should have the content 'Geocode'" do
			visit root_path
			expect(page).to have_content('Geocode Addresses')
		end
	end
end
