# pick a silly name, Cssette pronounced Cassette
module Cssette
	@compact_width = 500
	def split_css_by_width(css_string)
		compact = ""
		wide = ""
		is_compact = true
		brace_count = 0

		css_string.each_line do |css_line|
			# assume media queries start the line
			# and look for a min-width setting
			if css_line.strip.start_with? "@media"
				min_width = css_line[/min-width\s*?:\s*?([0-9]+)px/, 1].to_i
				is_compact = false if min_width > @compact_width
			end

			brace_count += css_line.count "{"
			compact += css_line if is_compact
			wide += css_line unless is_compact
			brace_count -= css_line.count "}"
			is_compact = true if brace_count == 0
		end
		[compact, wide]
	end
	module_function :split_css_by_width
end