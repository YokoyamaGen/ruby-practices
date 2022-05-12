require 'date'
require 'optparse'

opt = OptionParser.new

params = {}

opt.on('-y [VAL]') {|v| v }
opt.on('-m [VAL]') {|v| v }

opt.parse!(ARGV, into: params)

if params[:y].nil?
  year = Date.today.year
  month = (if params[:m].nil?
             Date.today.month
           else
             params[:m].to_i
           end)
else
  year = params[:y].to_i
  month = params[:m].to_i
end

month_beginning = Date.new(year, month, 1)
month_end = Date.new(year, month, -1)

puts "#{month}月 #{year}".center(21) 
puts " 日 月 火 水 木 金 土"

add_week_number = 1
default_output_width = 3

(month_beginning..month_end).each do |calendar_day|
  output_format = (if calendar_day == month_beginning
                     (calendar_day.wday + add_week_number) * default_output_width
                   else
                     default_output_width
                   end)
  if calendar_day.saturday? || calendar_day == month_end
    printf("%#{output_format}d\n", calendar_day.day)
  else
    printf("%#{output_format}d", calendar_day.day)
  end
end
