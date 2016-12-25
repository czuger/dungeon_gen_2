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
  end

  def draw( dungeon_image )
    dungeon_image = dungeon_image.composite( @room.room_image, @left * Room::TILE_SIZE, @top * Room::TILE_SIZE, OverCompositeOp )
    @borders.draw( dungeon_image )
  end

end