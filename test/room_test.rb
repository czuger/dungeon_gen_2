require 'test/unit'
require_relative '../libs/rooms/room'

class RoomTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
    @room = Room.new( [ 8, 8 ], position: Position.new( 0, 0 ) )
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_room_distance
    room2 = Room.new( [ 8, 8 ], position: Position.new( 9, 9 ) )
    assert_equal 3, @room.closest_distance( room2 )
  end
end