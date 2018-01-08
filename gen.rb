require 'pp'
require_relative 'libs/availables_tiles_pool/rooms'
require_relative 'libs/availables_tiles_pool/hallways'
require_relative 'libs/occupied_spaces'


os = OccupiedSpaces.new
rooms = AvailablesTilesPool::Rooms.new( os )
hallways = AvailablesTilesPool::Hallways.new( os )

rooms.set_hallways_pool( hallways )

placed_rooms = []

room = rooms.sample
placed_rooms << room.place( 0, 0 )

nb_rooms = 4
infinite_loop_protection = 1000

while nb_rooms > 0 and infinite_loop_protection > 0

  angle = rand( 0 .. 2*Math::PI )
  distance = rand( 1 .. 4 )

  top = ( distance * Math.sin( angle ) ).round
  left = ( distance * Math.cos( angle ) ).round

  room = rooms.sample

  if os.free_space?( room, top, left, 2 )
    placed_rooms << room.place( top, left )
    nb_rooms -= 1
  end

  infinite_loop_protection -= 1

end

min_left = max_left = min_top = max_top = 0

placed_rooms.each do |pr|
  min_left = [ pr.left, min_left ].min
  min_top = [ pr.top, min_top ].min
  max_left = [ pr.left, max_left ].max
  max_top = [ pr.top, max_top ].max
end

decal_left = min_left < 0 ? min_left.abs : 0
decal_top = min_top < 0 ? min_top.abs : 0

dungeon_image = Magick::Image.new(
    ( max_left + decal_left + 4 ) * 2 * AvailableTile::Base::TILE_SIZE,
    ( max_top + decal_top + 4 ) * 2 * AvailableTile::Base::TILE_SIZE )

placed_rooms.each do |pr|
  dungeon_image = pr.draw( dungeon_image, decal_top, decal_left )
end

dungeon_image.write( 'out/dungeon.jpg' )

