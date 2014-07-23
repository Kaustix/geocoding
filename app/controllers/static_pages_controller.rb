class StaticPagesController < ApplicationController
  include StaticPagesHelper
  def geocodes
  	@geoAddresses = GetGeoCodedAddresses(File.join(Rails.root, 
											 'app',
											 'assets', 
											 'csv', 
											 'GeocodeAddresses.csv'))
  end
end
