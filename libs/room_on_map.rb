require 'rmagick'

require_relative 'borders'

class RoomOnMap

  attr_reader :top, :left, :room

  include Magick

  def initialize( room, top, left )
    @room = room
    @top = top
    @left = left

    @room.occupied_space.add_room( self, top, left )
    @borders = Borders.new( self )

    @hallways = []
  end

  def draw( dungeon_image )
    p :draw
    @hallways.each{ |h| dungeon_image = h.draw( dungeon_image ) }
    dungeon_image = dungeon_image.composite( @room.room_image, @left * Room::TILE_SIZE, @top * Room::TILE_SIZE, OverCompositeOp )
    @borders.draw( dungeon_image )
  end

  def connect_hallway( hallways )
    border = @borders.sample
    h = hallways.choose( border )
    # p h
    @hallways << h.place( border )
  end

end