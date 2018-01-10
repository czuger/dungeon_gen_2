require_relative 'room'

class RectRoom < Room

  attr_reader :room_center

  ROOMS_SIZES = [ [ 2, 2 ], [ 2, 4 ], [ 4, 2 ], [ 4, 4 ] ]

  def initialize( nb_rooms )

    super()

    distance = nb_rooms * 1.5
    @room_distance = rand( 1 .. distance )
    @room_angle = rand( 0 .. 2*Math::PI )

    @room_center = Position.new( (@room_distance * Math.cos( @room_angle )).round( 0 ), (@room_distance * Math.sin( @room_angle )).round( 0 ) )

    room_size = ROOMS_SIZES.sample

    @room_height = room_size.first
    @room_width = room_size.last

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

  private

  def draw_room
    top_left_x, top_left_y, bottom_right_x, bottom_right_y = room_corners

    ( top_left_x .. bottom_right_x ).each do |x|
      ( top_left_y .. bottom_right_y ).each do |y|
        room_element = :floor
        # room_element = :wall if x == top_left_x || x == bottom_right_x || y == top_left_y || y == bottom_right_y
        @elements << RoomElement.new(Position.new(x, y ), room_element )
      end
    end
  end

end