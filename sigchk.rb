require 'origami'

abort "No arguments supplied" if ARGV.length < 1

ARGV.each do |fname|
  pdf = Origami::PDF.read( fname )
  pdf.each_field { |f| puts(f.T) ; puts(f.Rect.inspect) }
end