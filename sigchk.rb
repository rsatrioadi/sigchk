#!/usr/bin/env ruby
# coding: utf-8

require 'origami'

def extract_signature_fields(pdf)
  pdf.fields
    .select { |f| f.FT.to_s == "/Sig" }
    .map { |f| { :page_id => f.P.ID, :label => f.T, :rect => f.Rect } }
    .sort_by { |item| item[:page_id].to_i }
end

if __FILE__ == $0
  abort "No arguments supplied" if ARGV.length < 1
  ARGV.each do |fname|
    pdf = Origami::PDF.read( fname, verbosity: Origami::Parser::VERBOSE_QUIET, lazy: true )
    pdf.pages.each_with_index { |p,i| p.ID= i+1 if !p.ID }
    sigs = extract_signature_fields( pdf )
    puts fname + ": " + sigs.size.to_s + " signatures"
    puts sigs.map { |sig| "  " + sig.to_s }
  end
end
