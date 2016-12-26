require_relative 'base'
require_relative '../available_tile/room'

module AvailablesTilesPool
  class Rooms < Base

    def initialize( occupied_space )
      @tiles = []
      Dir.glob( 'tiles/rooms/*' ).each do |room|
        @tiles << AvailableTile::Room.new( room, occupied_space )
      end
    end

  end
end