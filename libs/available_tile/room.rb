require_relative 'base'
require_relative '../tile_on_map/room'

class AvailableTile::Room < AvailableTile::Base

  def place( top, left )
    r = TileOnMap::Room.new( self, top, left )
    r.connect_hallway
    r
  end

end