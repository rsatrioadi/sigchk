#!/usr/bin/env ruby
# coding: utf-8

require 'origami'

def extract_signature_fields(pdf)
  pdf.fields
    .select { |f| f.FT.to_s == "/Sig" }
    .map { |f| { :page_id => f.P.ID, :rect => f.Rect } }
    .sort_by { |item| item[:page_id].to_i }
end

if __FILE__ == $0
  abort "No arguments supplied" if ARGV.length < 1
  ARGV.each do |fname|
    puts fname
    pdf = Origami::PDF.read( fname, verbosity: Origami::Parser::VERBOSE_QUIET, lazy: true )
    pdf.pages.each_with_index { |p,i| p.ID= i+1 if !p.ID }
    sigs = extract_signature_fields( pdf )
    puts sigs
  end
end
