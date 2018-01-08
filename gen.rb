require 'pp'
require_relative 'libs/dungeon'

d = Dungeon.new
d.generate

d.to_pic

