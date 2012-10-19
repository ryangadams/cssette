require 'pathname'
$:.unshift File.join(File.dirname(Pathname.new($0).realpath.to_s), 'lib')

require 'cssette'

def concatenate_css(to, stuff, from_file)
	file_comment = "\n\n/*\t#{from_file}\t*/\n"
	to += file_comment + stuff + "\n" unless stuff.strip == ""
	to
end

compact = ""
tablet = ""
css_dir = "webapp/static/style/sharedmodules"
css_files = Dir.glob("**/*.css")

css_files.each { |filename| 
	puts "parsing #{filename}"
	File.open(filename, "r") { |file|
		c, t = Cssette.split_css_by_width(file.read)
		compact = concatenate_css(compact, c, filename)
		tablet = concatenate_css(tablet, t, filename)
	}
}
puts "------------------- COMPACT"
puts compact

puts "------------------- TABLET"
puts tablet

