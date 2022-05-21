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
puts " 日 月 火 水 木 金 土"

default_output_width = 3
printf("%#{month_beginning.wday * default_output_width}s", "")

(month_beginning..month_end).each do |calendar_day|
  new_line = calendar_day.saturday? || calendar_day == month_end ? "\n" : ""
  printf("%#{default_output_width}d#{new_line}", calendar_day.day)
end
