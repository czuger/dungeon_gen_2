require 'rmagick'

require_relative 'room_on_map'

class Room

  attr_reader :w, :h, :room_image, :occupied_space

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

  def place( top, left )
    RoomOnMap.new( self, top, left )
  end

end