require 'origami'

abort "Not enough arguments" if ARGV.length < 2

reference = Origami::PDF.read( ARGV[0], verbosity: Origami::Parser::VERBOSE_QUIET )
expected = reference.fields.select { |f| f.FT.to_s == "/Sig" }.map { |f| { :page_id => f.P.no, :rect => f.Rect } }

ARGV.drop(1).each do |a|

  inspected = Origami::PDF.read( a, verbosity: Origami::Parser::VERBOSE_QUIET )
  actual = inspected.fields.select { |f| f.FT.to_s == "/Sig" }.map { |f| { :page_id => f.P.no, :rect => f.Rect } }

  comp1 = actual - expected
  comp2 = expected - actual

  puts a if !(comp1|comp2).empty?
  if !(comp1).empty?
    puts "present but not expected:"
    puts comp1
  end
  if !(comp2).empty?
    puts "expected but not present:"
    puts comp2
  end
end