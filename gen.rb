require 'pp'
require_relative 'libs/rooms'
require_relative 'libs/hallways'
require_relative 'libs/occupied_spaces'

os = OccupiedSpaces.new
dungeon_image = Magick::Image.new( 30 * Room::TILE_SIZE, 30 * Room::TILE_SIZE )
rooms = Rooms.new( os )
hallways = Hallways.new( os )

placed_rooms = []

1.upto(1) do

  top = rand( 1 .. 22 )
  left = rand( 1 .. 22 )

  room = rooms.rand

  if os.free_space?( room, top, left )
    placed_rooms << room.place( top, left, hallways )
  end

end

placed_rooms.each do |pr|
  dungeon_image = pr.draw( dungeon_image )
end

dungeon_image.write( 'out/dungeon.jpg' )

