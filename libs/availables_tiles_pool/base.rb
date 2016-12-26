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

    def set_hallways_pool( hallways_pool )
      @tiles.each{ |e| e.set_hallways_pool( hallways_pool ) }
    end

    def inspect
      { object: self.class.to_s }
    end

  end
end