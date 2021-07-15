#!/usr/bin/env ruby
# coding: utf-8

require 'csv'
require_relative 'siggy'

if __FILE__ == $0
  abort "No arguments supplied" if ARGV.length < 3
  wis = CSV.read( ARGV[0] )
  dek = CSV.read( ARGV[1] )
  mode = ARGV[2].to_sym
  wis.drop( 1 ).each do |row|
    new_row = []
    nim = row[0]
    prodi = row[1]
    new_row << nim
    new_row << prodi
    page = 3
    # ratio = rat.detect { |row| (row[0]==prodi) && !(row[1].start_with?("reini")) }[7].to_f
    row.drop(2).each_slice(2) do |slice|
      new_row << page
      s = Siggy.new(slice[0].to_f,slice[1].to_f,1.9820997)
      s.bound.map { |v| v.floor }.each { |v| new_row << v }
      page += 1
    end
    if mode==:dekan
      dek.select { |row| row[0]==prodi && !(row[1].start_with?("reini")) }.each { |row| row.drop( 2 ).each { |v| new_row << v }}
    else
      dek.select { |row| row[0]==prodi }.each { |row| row.drop( 2 ).each { |v| new_row << v }}
    end
    if mode==:tera
      if nim.start_with? '3'
        new_row << [1, 529, 101, 648, 219]
      else
        new_row << [1, 443, 101, 563, 218]
      end
    end
    puts new_row.join( ',' )
  end
end
