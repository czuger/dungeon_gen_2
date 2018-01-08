require_relative 'base'
require_relative '../available_tile/room'

module AvailablesTilesPool
  class Rooms < Base

    def initialize()

      @tiles = []
      Dir.glob( 'tiles/rooms/*' ).each do |room|
        p room
        next unless room =~ /b_4_4/
        @tiles << AvailableTile::Room.new( room )
      end

    end

  end
end