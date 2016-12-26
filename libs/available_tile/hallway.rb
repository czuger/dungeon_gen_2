require_relative 'base'
require_relative '../tile_on_map/hallway'

class AvailableTile::Hallway < AvailableTile::Base

  def vertical?
    @h < @w
  end

  def place( border )
    top = border.top - 1
    left = border.left - 1

    top -= @h if border.side == :top
    top += 1 if border.side == :bottom
    left -= @w if border.side == :left
    left += 1 if border.side == :right

    TileOnMap::Hallway.new(self, top, left )
  end

end