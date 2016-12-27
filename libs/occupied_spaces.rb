require 'set'

class OccupiedSpaces

  def initialize
    @occupied_spaces = Set.new
  end

  def add_tile( tile_on_map, top, left )
    0.upto( tile_on_map.w-1 ).each do |uw|
      0.upto( tile_on_map.h-1 ).each do |uh|
        @occupied_spaces << [ uw+left, uh+top ]
      end
    end
  end

  def free_space?( tile, top, left )
    0.upto( tile.w-1 ).each do |uw|
      0.upto( tile.h-1 ).each do |uh|
        return false if @occupied_spaces.include?( [ uw+left, uh+top ] )
      end
    end
    true
  end

  def inspect
    { object: self.class.to_s, occupied_spaces_count: @occupied_spaces.count }
  end

end