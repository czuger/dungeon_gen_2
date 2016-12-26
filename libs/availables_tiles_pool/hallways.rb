require_relative '../available_tile/hallway'
require_relative 'base'

class AvailablesTilesPool::Hallways < AvailablesTilesPool::Base

  BORDER_CONV = { top: :bottom, bottom: :top, left: :right, right: :left }

  def initialize( occupied_space )
    @hallways = {}
    Dir.glob( 'tiles/hallways/*' ).each do |hallway|
      h = AvailableTile::Hallway.new( hallway, occupied_space )

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
