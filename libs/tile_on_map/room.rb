require_relative 'base'

require_relative '../borders'

class TileOnMap::Room < TileOnMap::Base

  def initialize( tile, top, left )
    super( tile, top, left )
    @borders = Borders.new( self )
  end

  def connect_hallway
    @hallways ||= []

    border = @borders.sample

    hallway = @hallways_pool.choose( border )

    if @occupied_space.free_space?( hallway, top, left )
      @hallways << h.place( border )
    end

  end

end