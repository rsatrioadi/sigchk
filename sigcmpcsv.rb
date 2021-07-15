#!/usr/bin/env ruby
# coding: utf-8

require 'origami'
require 'csv'
require_relative 'arraydiff'
require_relative 'sigchk'

if __FILE__ == $0
  abort "Not enough arguments" if ARGV.length < 2

  csv = CSV.read( ARGV[0] )

  ARGV.drop(1).each do |a|
    if csv.any? { |row| File.basename(a).include?( row[0].to_s ) }
      expected = csv.detect { |row| File.basename(a).include?( row[0].to_s ) }

      nim = expected[0]

      expected = expected
        .drop( 2 )
        .each_slice( 5 )
        .map { |slice| { :page_id => slice[0].to_i, :rect => slice.drop( 1 ).map { |v| v.to_i } } }
        .sort_by { |item| item[:page_id] }
        .map { |sig| sig.to_s }

      inspected = Origami::PDF.read( a, verbosity: Origami::Parser::VERBOSE_QUIET, lazy: true )
      inspected.pages.each_with_index { |p,i| p.ID= i+1 if !p.ID }
      actual = extract_signature_fields( inspected )
        .each { |sig| sig.delete( :label ) }
        .map { |sig| sig.to_s }

      comp1 = actual.difference expected
      comp2 = expected.difference actual

      if !comp1.empty? || !comp2.empty?
        report = "#{nim},"
        report += comp1.size.to_s + " extra " unless comp1.empty?
        report += comp2.size.to_s + " missing" unless comp2.empty?
        puts report
      else
        puts "#{nim},OK"
      end

      # puts a + ": " + actual.size.to_s + " signatures"
      # puts "  "+comp1.size.to_s+" present but not expected:", comp1.map { |sig| "    " + sig.to_s } if !comp1.empty?
      # puts "  "+comp2.size.to_s+" expected but not present:", comp2.map { |sig| "    " + sig.to_s } if !comp2.empty?
    end
  end
end
