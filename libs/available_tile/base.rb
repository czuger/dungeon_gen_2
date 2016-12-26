require 'rmagick'

module AvailableTile
  class Base

    attr_reader :w, :h, :tile_image, :occupied_space

    include Magick

    TILE_SIZE = 100

    def initialize( tile, occupied_space )

      @tile_image = ImageList.new( tile ).first
      @occupied_space = occupied_space

      fname = File.basename( tile )
      m = fname.match( /(\d)_(\d)/ )
      @w = m[1].to_i
      @h = m[2].to_i
      @tile_image = @tile_image.scale(TILE_SIZE * @w, TILE_SIZE * @h )
    end

  end
end