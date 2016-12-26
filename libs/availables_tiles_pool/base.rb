module AvailablesTilesPool
  class Base

    def sample
      @tiles.sample
    end

    def each
      @tiles.each do |room|
        yield room
      end
    end

  end
end