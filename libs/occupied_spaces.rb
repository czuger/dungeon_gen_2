require 'set'

class OccupiedSpaces

  def initialize
    @occupied_spaces = Set.new
  end

  def add_room( room_on_map, top, left )
    0.upto( room_on_map.room.w-1 ).each do |uw|
      0.upto( room_on_map.room.h-1 ).each do |uh|
        @occupied_spaces << [ uw+left, uh+top ]
      end
    end
  end

  def free_space?( room, top, left )
    0.upto( room.w-1 ).each do |uw|
      0.upto( room.h-1 ).each do |uh|
        return false if @occupied_spaces.include?( [ uw+left, uh+top ] )
      end
    end
    true
  end

end