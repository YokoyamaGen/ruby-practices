require 'date'
require 'optparse'

opt = OptionParser.new

params = {}

opt.on('-y [VAL]') {|v| v }
opt.on('-m [VAL]') {|v| v }

opt.parse!(ARGV, into: params)

if params[:y].nil?
  year = Date.today.year
  month = params[:m].nil? ? Date.today.month : params[:m].to_i
else
  year = params[:y].to_i
  month = params[:m].to_i
end

month_beginning = Date.new(year, month, 1)
month_end = Date.new(year, month, -1)

puts "#{month}月 #{year}".center(21) 
puts "日 月 火 水 木 金 土"

WIDTH = 3
print " " * (month_beginning.wday * WIDTH)

(month_beginning..month_end).each do |calendar_day|
  print calendar_day.day.to_s.center(WIDTH)
  puts if calendar_day.saturday? || calendar_day == month_end
end

puts
