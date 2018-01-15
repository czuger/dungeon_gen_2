require_relative 'room'

class RectRoom < Room

  attr_reader :room_center, :elements

  ROOMS_SIZES = [ [ 2, 2 ], [ 2, 4 ], [ 4, 2 ], [ 4, 4 ] ]

  def initialize
    @elements = []

    room_size = ROOMS_SIZES.sample

    @room_height = room_size.first
    @room_width = room_size.last

    @room_center = Position.new( 0, 0 )
    draw_room
  end

  def move_room( room_angle, room_distance )
    @room_center = Position.new( (room_distance * Math.cos( room_angle )).round( 0 ), (room_distance * Math.sin( room_angle )).round( 0 ) )
    @elements = []
    draw_room
  end

  def room_hash_keys_footprint
    @elements.map{ |r| r.position }.flatten.uniq.map{ |e| e.hash_key }
  end

  def room_hash_keys_phantom
    @elements.map{ |r| r.position }.map{ |p| p.adjacent_positions }.flatten.uniq.map{ |e| e.hash_key } - room_hash_keys_footprint
  end

  def room_corners
    [ top_left_x, top_left_y, bottom_right_x, bottom_right_y ]
  end

  def bottom_right_x
    (@room_height/2.0).floor + @room_center.x - 1
  end

  def bottom_right_y
    (@room_width/2.0).floor + @room_center.y - 1
  end

  def top_left_x
    -(@room_height/2.0).ceil + @room_center.x
  end

  def top_left_y
    -(@room_width/2.0).ceil + @room_center.y
  end

  def room_x_coords
    @elements.map{ |e| e.position.x }.uniq
  end

  def room_y_coords
    @elements.map{ |e| e.position.y }.uniq
  end

  # Return the diagonal room size, used for room placement
  def diagonal_size
    Math.sqrt( @room_height * @room_height + @room_width * @room_width ).round(0)
  end

  # Compute the distance between two rooms (in cases) used in room placement
  def distance( room )
    @room_center.distance( room.room_center )
  end

  # Return the distance of the closest elements of two rooms
  def closest_distance( room )
    lowest_distance = Float::INFINITY

    @elements.each do |e1|
      room.elements.each do |e2|
        distance = e1.position.distance( e2.position )
        # puts "In rect_room.closes_distance. distance = #{distance}"
        lowest_distance = [ distance, lowest_distance ].min
      end
    end

    lowest_distance
  end

  def draw_room
    top_left_x, top_left_y, bottom_right_x, bottom_right_y = room_corners

    ( top_left_x .. bottom_right_x ).each do |x|
      ( top_left_y .. bottom_right_y ).each do |y|
        room_element = :room
        @elements << RoomElement.new(Position.new(x, y ), room_element )
      end
    end
  end

  # This method is used to finalize the room position. It definitively mark the room cases as occupied.
  # Required for hallway positions.
  def finalize_room_position( dungeon )
    @elements.each do |element|
      dungeon.set_case_occuped( element.position )
    end
  end

end