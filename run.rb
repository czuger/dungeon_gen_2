require_relative 'libs/dungeon/dungeon'

d = Dungeon.new( 16 )
d.print_dungeon_ascii
# d.print_dungeon_limited_bmp
d.print_dungeon_full_bmp
