require 'origami'

abort "No arguments supplied" if ARGV.length < 1

ARGV.each do |fname|
  pdf = Origami::PDF.read( fname, verbosity: Origami::Parser::VERBOSE_QUIET )
  pdf.each_field do |f| 
    print( f.T, " " )
    puts( f.Rect.join( " " )) 
  end
end