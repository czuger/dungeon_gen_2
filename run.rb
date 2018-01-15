require_relative 'libs/dungeon/dungeon'

superseed = nil
# superseed = 311593924271807075583079921132683299447
seed = superseed ? superseed : Random.new_seed
puts "Dungeon seed = #{seed}"
srand( seed )

d = Dungeon.new( 20 )
d.print_dungeon_ascii
# d.print_dungeon_limited_bmp
d.print_dungeon_full_bmp
