require 'rmagick'

module TileOnMap
  class Base

    attr_reader :top, :left, :w, :h

    include Magick

    def initialize( tile, top, left )

      @top = top
      @left = left

      @w = tile.w
      @h = tile.h

      @hallways_pool = tile.hallways_pool
      @tile_image = tile.tile_image
      @occupied_space = tile.occupied_space

      @occupied_space.add_tile(self, top, left )
    end

    def draw( dungeon_image, decal_top, decal_left )

      p self
      @hallways&.each{ |h| dungeon_image = h.draw( dungeon_image ) }

      dungeon_image = dungeon_image.composite( @tile_image,
         ( @left + decal_left ) * 2 * AvailableTile::Base::TILE_SIZE,
         ( @top + decal_top ) * 2 * AvailableTile::Base::TILE_SIZE, OverCompositeOp )

      # @borders&.draw( dungeon_image )

      dungeon_image
    end

    # def inspect
    #   { top: @top, left: @left, w: @w, h: @h }
    # end

  end
end