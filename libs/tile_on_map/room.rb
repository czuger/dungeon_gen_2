require_relative 'base'

class TileOnMap::Room < TileOnMap::Base

  def connect_hallway( hallways )
    @hallways ||= []

    border = @borders.sample
    h = hallways.choose( border )
    # p h
    @hallways << h.place( border )
  end

end