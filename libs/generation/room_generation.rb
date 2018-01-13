require_relative '../rooms/rect_room'

module RoomGeneration

  def create_rooms( max_rooms )

    # The cases really occuped by the room
    @occuped_cases = Set.new
    # The cases around the room to avoid accoladed rooms
    @room_phantom_cases = Set.new

    @rooms = []

    1.upto( max_rooms ) do
      room = RectRoom.new
      move_room(room )
      @rooms << room
    end
    # while( @rooms.count < nb_rooms ) do
    #
    #   room.position_room( nb_rooms )
    #   if ( @occuped_cases & room.room_hash_keys_footprint ).empty? && ( @room_phantom_cases & room.room_hash_keys_phantom ).empty?
    #     @rooms << room
    #     @occuped_cases += room.room_hash_keys_footprint
    #     @room_phantom_cases += room.room_hash_keys_phantom
    #   end
    # end
  end

  private

  # Choose a random direction and move the room until it is fare engough from other rooms.
  def move_room(room )
    unless @rooms.empty?
      room_angle = rand( 0 .. 2*Math::PI )
      distance = 4
      loop do
        distance += 1
        p distance
        room.move_room( room_angle, distance )
        _, nearest_room_distance = nearest_room( room )
        p nearest_room_distance
        break if nearest_room_distance > room.diagonal_size * 1.5
      end
    end

    room.draw_room

  end

  # Compute the nearest room for the current room
  # Return the room and the distance of the room
  def nearest_room( current_room )
    tmp_rooms = @rooms.clone
    nearest_room = room = tmp_rooms.shift
    lowest_distance = room.distance( current_room )
    until tmp_rooms.empty?
      p tmp_rooms
      distance = current_room.distance( room )
      if distance < lowest_distance
        nearest_room = room
        lowest_distance = distance
      end
      room = tmp_rooms.shift
    end
    [ nearest_room, lowest_distance ]
  end

end