require_relative '../rooms/room'

module RoomGeneration

  def create_rooms( max_rooms )
    @rooms = []

    1.upto( max_rooms ) do
      room = Room.new
      move_room(room )
      @rooms << room
      room.finalize_room_position( self )
    end
  end

  private

  # Choose a random direction and move the room until it is fare engough from other rooms.
  def move_room(room )
    unless @rooms.empty?
      room_angle = 0
      distance = 4
      loop do
        room_angle += rand( 0 .. Math::PI/8 )
        if room_angle >= 2*Math::PI
          distance += 2
          room_angle = 0
        end
        # p "distance = #{distance}"
        room.move_room( room_angle, distance )
        lowest_distance = closest_position( room )
        # p "nearest_room_distance = #{lowest_distance}"
        break if lowest_distance >= rand( 3 .. 6 )
      end
    end

    room.draw_room
  end

  # Compute the distance to the closes element of the closest room from the current room.
  def closest_position( current_room )
    lowest_distance = Float::INFINITY
    @rooms.each do |room|
      closest_distance = current_room.closest_distance( room )

      lowest_distance = [ closest_distance, lowest_distance ].min
      break if lowest_distance <= 0
    end
    lowest_distance
  end

end