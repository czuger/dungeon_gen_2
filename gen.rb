require 'pp'
require_relative 'libs/availables_tiles_pool/rooms'
require_relative 'libs/availables_tiles_pool/hallways'
require_relative 'libs/occupied_spaces'

dungeon_width = 30
dungeon_height = 30
os = OccupiedSpaces.new
dungeon_image = Magick::Image.new( dungeon_width * AvailableTile::Base::TILE_SIZE, dungeon_height * AvailableTile::Base::TILE_SIZE )
rooms = AvailablesTilesPool::Rooms.new( os )
hallways = AvailablesTilesPool::Hallways.new( os )

rooms.set_hallways_pool( hallways )

placed_rooms = []

# Place first room (always center)
room = rooms.sample
top = dungeon_height / 2 - room.h / 2 + rand( - room.h .. room.h )
left = dungeon_width / 2 - room.w / 2+  rand( - room.w .. room.w )

placed_rooms << room.place( top, left )

nb_rooms = 6
infinite_loop_protection = 1000

while nb_rooms > 0 and infinite_loop_protection > 0

  top = rand( 1 .. 22 )
  left = rand( 1 .. 22 )

  room = rooms.sample

  if os.free_space?( room, top, left, 3 )
    placed_rooms << room.place( top, left )
    nb_rooms -= 1
  end

  infinite_loop_protection -= 1

end

placed_rooms.each do |pr|
  dungeon_image = pr.draw( dungeon_image )
end

dungeon_image.write( 'out/dungeon.jpg' )

