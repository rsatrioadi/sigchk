require 'origami'

abort "No arguments supplied" if ARGV.length < 1

ARGV.each do |fname|
  puts fname
  pdf = Origami::PDF.read( fname, verbosity: Origami::Parser::VERBOSE_QUIET )
  sigs = pdf.fields.select { |f| f.FT.to_s == "/Sig" }.map { |f| { :page_id => f.P.no, :rect => f.Rect } }
  puts sigs
end