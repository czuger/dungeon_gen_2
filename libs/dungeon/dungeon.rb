require 'pp'
require_relative '../../libs/position'
require_relative '../../libs/game/dungeon_ascii_print'
require_relative '../../libs/rooms/room'
require_relative '../../libs/rooms/rooms_connection'
require_relative '../../libs/game/dungeon_bmp_print'
require_relative '../../libs/game/movement_in_dungeon'
require_relative '../../libs/generation/room_generation'
require 'set'

class Dungeon

  include DungeonAsciiPrint
  include DungeonBmpPrint
  include RoomsConnection
  include MovementInDungeon
  include RoomGeneration

  WATCH_DISTANCE=4

  attr_reader :current_room

  def initialize( max_room=20 )

    # The cases really occuped by the room
    @occuped_cases = Set.new

    create_rooms( max_room )
    connect_rooms

    # @last_pos = @rooms.first.room_center.clone
    # @current_pos = @rooms.first.room_center.clone
    #
    # # Set dungeon content
    # @dungeon_content = {}
    #
    # # Monsters generation, each room has halve a chance of having a monster
    # @rooms.each do |room|
    #   monster = @rooms.first != room && rand( 1 .. 2 ) == 1 ? 'M' : nil
    #   if monster
    #     @dungeon_content[ room.room_center.hash_key ] = [ monster ]
    #   end
    # end
    #
    # # Treasure generation.
    # # 10% chance of a trapped chest rather than a single treasure (still contain treasure)
    # # C = Chest, mean trapped chest containing hoard, H = Hoard, mean non trapped hoard
    # treasure_room = nil
    # greatest_distance = -Float::INFINITY
    # @rooms.each do |room|
    #   distance = @rooms.first.room_center.distance( room.room_center )
    #   if distance > greatest_distance
    #     greatest_distance = distance
    #     treasure_room = room
    #   end
    # end
    # treasure = rand( 1 .. 10 ) == 1 ? 'C' : 'H'
    # @dungeon_content[ treasure_room.room_center.hash_key ] ||= []
    # @dungeon_content[ treasure_room.room_center.hash_key ] << treasure
    #
    # # Traps generation
    # @hallways.each do |hallway|
    #   trap = rand( 1 .. 5 ) == 1 ? 'T' : nil
    #   trap_position = hallway.hallway_floors_positions.sample
    #   @dungeon_content[ trap_position.hash_key ] = [] unless @dungeon_content[ trap_position.hash_key ]
    #   @dungeon_content[ trap_position.hash_key ] << trap if trap
    # end

    # pp @dungeon_content

  end

  def case_occuped?( pos )
    raise unless pos.is_a? Position
    @occuped_cases.include?( pos.hash_key )
  end

  def set_case_occuped( pos )
    raise unless pos.is_a? Position
    @occuped_cases << pos.hash_key
  end

  def elements_to_cases
    @cases = {}
    @rooms.each do |room|
      room.set_cases( @cases )
    end
    @hallways.each do |hallway|
      hallway.set_cases( @cases )
    end
  end

  # def move_into_dungeon( exit_number )
  #   @current_position = @current_room.exits.get_exit_by_no( exit_number )
  #   puts 'Entrez la direction de la porte (0 = top, 1 = bottom, 2 = left, 3 = right)'
  #   num = gets.chomp
  #   @current_position.set_direction( num.to_i )
  #   @current_room = DungeonElement.new( self, @current_position )
  # end

  def compute_dungeon_corners
    @d_top_left_x = @d_top_left_y = @d_bottom_right_x = @d_bottom_right_y = 0
    @rooms.each do |room|
      top_left_x, top_left_y, bottom_right_x, bottom_right_y = room.room_corners

      @d_top_left_x = top_left_x if top_left_x < @d_top_left_x
      @d_top_left_y = top_left_y if top_left_y < @d_top_left_y

      @d_bottom_right_x = bottom_right_x if bottom_right_x > @d_bottom_right_x
      @d_bottom_right_y = bottom_right_y if bottom_right_y > @d_bottom_right_y
    end
  end

end



