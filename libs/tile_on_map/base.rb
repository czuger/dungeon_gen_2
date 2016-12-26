require 'rmagick'

require_relative '../borders'

module TileOnMap
  class Base

    attr_reader :top, :left, :tile

    include Magick

    def initialize( room, top, left )
      @tile = room
      @top = top
      @left = left

      @tile.occupied_space.add_tile(self, top, left )
      @borders = Borders.new( self )
    end

    def draw( dungeon_image )
      p self
      @hallways.each{ |h| dungeon_image = h.draw( dungeon_image ) } if @hallways
      dungeon_image = dungeon_image.composite(@tile.tile_image, @left * AvailableTile::Base::TILE_SIZE, @top * AvailableTile::Base::TILE_SIZE, OverCompositeOp )
      @borders.draw( dungeon_image )
    end
  end
end