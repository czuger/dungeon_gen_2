require_relative 'hallway'
require_relative 'rooms'
require_relative 'hallway_on_map'

class Hallways < Rooms

  BORDER_CONV = { top: :bottom, bottom: :top, left: :right, right: :left }

  def initialize( occupied_space )
    @hallways = {}
    Dir.glob( 'tiles/hallways/*' ).each do |hallway|
      h = Hallway.new( hallway, occupied_space )

      if !h.vertical?
        [ :top, :bottom ].each do |way|
          @hallways[ way ] ||= []
          @hallways[ way ] << h
        end
      else
        [ :left, :right ].each do |way|
          @hallways[ way ] ||= []
          @hallways[ way ] << h
        end
      end
    end
  end

  def choose( border )
    @hallways[ BORDER_CONV[ border.side ] ].sample
  end

end