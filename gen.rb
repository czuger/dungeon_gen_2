require 'pp'
require_relative 'libs/rooms'
require_relative 'libs/hallways'
require_relative 'libs/occupied_spaces'

os = OccupiedSpaces.new
dungeon_image = Magick::Image.new( 30 * Room::TILE_SIZE, 30 * Room::TILE_SIZE )
rooms = Rooms.new( os )
hallways = Hallways.new( os )

1.upto(10) do

  top = rand( 1 .. 22 )
  left = rand( 1 .. 22 )

  if rand( 1 .. 2 ) == 1
    room = rooms.rand
  else
    room = hallways.rand
  end

  if os.free_space?( room, top, left )
    dungeon_image = room.draw( dungeon_image, top, left )
  end

end

dungeon_image.write( 'out/dungeon.jpg' )

