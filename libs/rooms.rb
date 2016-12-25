require_relative 'room'

class Rooms

  def initialize( occupied_space )
    @rooms = []
    Dir.glob( 'tiles/rooms/*' ).each do |room|
      @rooms << Room.new( room, occupied_space )
    end
  end

  def rand
    @rooms.sample
  end

  def each
    @rooms.each do |room|
      yield room
    end
  end

end