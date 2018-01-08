require_relative 'base'
require_relative '../tile_on_map/hallway'

class AvailableTile::Hallway < AvailableTile::Base

  def vertical?
    @h < @w
  end

end