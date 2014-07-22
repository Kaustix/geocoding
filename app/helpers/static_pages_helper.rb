require 'smarter_csv'

module StaticPagesHelper
	def ImportCSV(filename)
		return nil if filename.blank?

		results = SmarterCSV.process(filename, options_hash)
	end
end
