require 'docx'
require 'colorize'

files = Dir.glob('files/*').select { |e| File.file? e }

lines = []

# parse files
files.each do |file|
  puts "Parse file: #{file}...".yellow
  doc = Docx::Document.open(file)
  
  doc.paragraphs.each do |line|
    lines << line.to_s
  end
  puts "Parsed: #{file}".green
end

# clean text
puts 'Clean text...'.yellow
lines.map do |line|
  line.gsub! '* * *', ''
  line.gsub! /.+Глава \d+.+/, ''
  line.strip!
end
puts 'Cleaned'.green

puts 'Reject empty lines...'.yellow
lines.reject!(&:empty?)
puts 'Rejected'.green

output = "const text = `#{lines.join("\n")}`\n\nmodule.exports = text"

puts 'Save result...'.yellow
File.write('output/states.js', output)
puts 'Saved'.green

