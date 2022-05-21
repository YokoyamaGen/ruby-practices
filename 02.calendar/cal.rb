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
calculate_width = month_beginning.sunday? ? 0 : 1
print " " * (month_beginning.wday * WIDTH - calculate_width)

(month_beginning..month_end).each do |calendar_day|
  new_line = calendar_day.saturday? || calendar_day == month_end ? "\n" : ""
  width = calendar_day.sunday? ? 2 : 3
  printf("%#{width}d#{new_line}", calendar_day.day)
end

puts
