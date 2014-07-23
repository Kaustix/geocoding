module StaticPagesHelper
	def ImportCSV(filename)
		return nil if filename.blank?
		print filename
		results = []

		File.read(filename).each_line do |line|
			results << line.chomp
		end

		return results
	end
end
