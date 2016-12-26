require 'pp'
require_relative 'libs/availables_tiles_pool/rooms'
require_relative 'libs/availables_tiles_pool/hallways'
require_relative 'libs/occupied_spaces'

os = OccupiedSpaces.new
dungeon_image = Magick::Image.new( 30 * AvailableTile::Base::TILE_SIZE, 30 * AvailableTile::Base::TILE_SIZE )
rooms = AvailablesTilesPool::Rooms.new( os )
hallways = AvailablesTilesPool::Hallways.new( os )

rooms.set_hallways_pool( hallways )

placed_rooms = []

1.upto(1) do

  top = rand( 1 .. 22 )
  left = rand( 1 .. 22 )

  room = rooms.sample

  if os.free_space?( room, top, left )
    placed_rooms << room.place( top, left )
  end

end

placed_rooms.each do |pr|
  dungeon_image = pr.draw( dungeon_image )
end

dungeon_image.write( 'out/dungeon.jpg' )

