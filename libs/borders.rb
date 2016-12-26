require_relative 'border'

class Borders

  def initialize( tile_on_map )
    @borders = []

    @borders += 2.upto( tile_on_map.tile.w-1 ).map{ |w| [
      Border.new( 1 + tile_on_map.top, w + tile_on_map.left, :top ),
      Border.new( tile_on_map.tile.h + tile_on_map.top, w + tile_on_map.left, :bottom ) ] }.flatten

    @borders += 2.upto( tile_on_map.tile.h-1 ).map{ |h| [
      Border.new( h + tile_on_map.top, 1 + tile_on_map.left, :left ),
      Border.new( h + tile_on_map.top, tile_on_map.tile.w + tile_on_map.left, :right ) ] }.flatten

    # # @borders += 2.upto( tile_on_map.h-2 ).map{ |h| [ Border.new( h, 1 ), Border.new( h, tile_on_map.w ) ] }.flatten
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