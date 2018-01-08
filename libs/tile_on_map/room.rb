require_relative 'base'

require_relative 'borders'

class TileOnMap::Room < TileOnMap::Base

  def initialize( occupied_space, tile, top, left )
    super( occupied_space, tile, top, left )
    @borders = Borders.new( self )
  end

  def connect_hallway( occupied_space, hallways_pool )
    @hallways ||= []

    border = @borders.sample

    hallway = hallways_pool.choose( border )

    if @occupied_space.free_space?( hallway, top, left )
      @hallways << h.place( border )
    end

  end

end