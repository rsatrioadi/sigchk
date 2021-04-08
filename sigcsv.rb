#!/usr/bin/env ruby
# coding: utf-8

require 'origami'
require_relative 'sigchk'

if __FILE__ == $0
  abort "No arguments supplied" if ARGV.length < 1
  ARGV.each do |fname|
    pdf = Origami::PDF.read( fname, verbosity: Origami::Parser::VERBOSE_QUIET, lazy: true )
    pdf.pages.each_with_index { |p,i| p.ID= i+1 if !p.ID }
    sigs = extract_signature_fields( pdf ).each { |sig| sig.delete( :label ) }
    # puts sigs.to_s
    puts [ fname, fname[0..2], sigs.map { |sig| sig.values.join( ',' ) }.join( ',' ) ].join( ',' )
  end
end
