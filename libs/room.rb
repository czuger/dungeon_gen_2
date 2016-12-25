require 'rmagick'

class Room

  attr_reader :w, :h
  include Magick

  TILE_SIZE = 100

  def initialize( room, occupied_space )

    @room_image = ImageList.new( room ).first
    @occupied_space = occupied_space

    fname = File.basename( room )
    m = fname.match( /(\d)_(\d)/ )
    @w = m[1].to_i
    @h = m[2].to_i
    @room_image = @room_image.scale( TILE_SIZE * @w, TILE_SIZE * @h )
  end

  def draw( dungeon_image, top, left )
    p [ top, left, self ]
    @occupied_space.add_room( self, top, left )
    dungeon_image.composite( @room_image, left * TILE_SIZE, top * TILE_SIZE, OverCompositeOp )
  end

end