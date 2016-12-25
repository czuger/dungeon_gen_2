require_relative 'border'

class Borders

  def initialize( room_on_map )
    @borders = []

    @borders += 2.upto( room_on_map.room.w-1 ).map{ |w| [
      Border.new( 1 + room_on_map.top, w + room_on_map.left, :top ),
      Border.new( room_on_map.room.h + room_on_map.top, w + room_on_map.left, :bottom ) ] }.flatten

    @borders += 2.upto( room_on_map.room.h-1 ).map{ |h| [
      Border.new( h + room_on_map.top, 1 + room_on_map.left, :left ),
      Border.new( h + room_on_map.top, room_on_map.room.w + room_on_map.left, :right ) ] }.flatten

    # # @borders += 2.upto( room_on_map.h-2 ).map{ |h| [ Border.new( h, 1 ), Border.new( h, room_on_map.w ) ] }.flatten
    @borders.sort!
  end

  def draw( dunegon_image )
    @borders.each do |border|
      dunegon_image = border.draw( dunegon_image )
    end
    dunegon_image
  end

  def sample
    @borders.sample
  end
end