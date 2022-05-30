#!/usr/bin/env ruby
# frozen_string_literal: true

scores = ARGV[0].split(',')

NINE_FRAME = 9
BEFORE_LAST_THROW = scores.count - 1
STRIKE = 10
FIRST_THROW = 1
SPARE = 10

shots = []
frames_tmp = []
scores.each_with_index do |s, i|
  shots << (s == 'X' ? STRIKE : s.to_i)

  next if (shots[0] != STRIKE && shots.count == FIRST_THROW) || (frames_tmp.count >= NINE_FRAME && i < BEFORE_LAST_THROW)

  frames_tmp << shots
  shots = []
end

frames = frames_tmp.each_cons(3).map(&:flatten)
frames += frames_tmp[-2..].each_cons(2).map(&:flatten)
frames << frames_tmp[-1]

point = 0
frames.each do |frame|
  point += if frame[0] == STRIKE || frame[0..1].sum == SPARE
             frame[0..2].sum
           else
             frame[0..1].sum
           end
end
puts point
