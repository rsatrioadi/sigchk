require 'fileutils'

if __FILE__ == $0
  abort "No arguments supplied" if ARGV.length < 2

  baru = File.readlines(ARGV[0]).map {|row|row.strip}
  checked = File.readlines(ARGV[1]).map {|row|row[-13..-6]}

  baru_clean = baru.reject {|r| checked.include? r[-8..-1]}
  baru_clean.each{|r| puts r}

  checked_missing = checked.reject {|r| baru.map{|x|x[-8..-1]}.include? r}
  checked_missing.each do |r| 
    puts r
    FileUtils.mv("apr2021/tera/checked/ecert-signed-#{r}.pdf", "apr2021/tera/resigning/ecert-signed-#{r}.pdf")
  end

end