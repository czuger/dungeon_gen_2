require_relative 'hallway'
require_relative 'rooms'

class Hallways < Rooms

  def initialize( occupied_space )
    @rooms = []
    Dir.glob( 'tiles/hallways/*' ).each do |hallway|
      @rooms << Hallway.new( hallway, occupied_space )
    end
  end

end