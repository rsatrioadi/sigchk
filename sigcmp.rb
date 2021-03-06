#!/usr/bin/env ruby
# coding: utf-8

require 'origami'
require_relative 'arraydiff'
require_relative 'sigchk'

if __FILE__ == $0
  abort "Not enough arguments" if ARGV.length < 2

  reference = Origami::PDF.read( ARGV[0], verbosity: Origami::Parser::VERBOSE_QUIET, lazy: true )
  reference.pages.each_with_index { |p,i| p.ID= i+1 if !p.ID }
  expected = extract_signature_fields( reference )

  ARGV.drop(1).each do |a|

    inspected = Origami::PDF.read( a, verbosity: Origami::Parser::VERBOSE_QUIET, lazy: true )
    inspected.pages.each_with_index { |p,i| p.ID= i+1 if !p.ID }
    actual = extract_signature_fields( inspected )

    comp1 = actual.difference expected
    comp2 = expected.difference actual

    if !comp1.empty? || !comp2.empty?
      report = a.gsub( /_\d\.pdf/, "" ) + ","
      report += comp1.size.to_s + " extra " unless comp1.empty?
      report += comp2.size.to_s + " missing" unless comp2.empty?
      puts report
    end

    # puts a + ": " + actual.size.to_s + " signatures"
    # puts "  "+comp1.size.to_s+" present but not expected:", comp1.map { |sig| "    " + sig.to_s } if !comp1.empty?
    # puts "  "+comp2.size.to_s+" expected but not present:", comp2.map { |sig| "    " + sig.to_s } if !comp2.empty?
  end
end
