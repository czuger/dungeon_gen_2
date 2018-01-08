require_relative 'availables_tiles_pool/rooms'
require_relative 'availables_tiles_pool/hallways'
require_relative 'occupied_spaces'

class Dungeon

  def initialize
    @occupied_spaces = OccupiedSpaces.new
    @availables_rooms = AvailablesTilesPool::Rooms.new()
    @availables_hallways = AvailablesTilesPool::Hallways.new()
    @tiles = []
  end

  def generate
    room = @availables_rooms.sample
    place_room( room,0,0 )
  end

  def to_pic()
    min_left = max_left = min_top = max_top = 0

    @tiles.each do |pr|
      min_left = [ pr.left, min_left ].min
      min_top = [ pr.top, min_top ].min
      max_left = [ pr.left, max_left ].max
      max_top = [ pr.top, max_top ].max
    end

    decal_left = min_left < 0 ? min_left.abs : 0
    decal_top = min_top < 0 ? min_top.abs : 0

    dungeon_image = Magick::Image.new(
        ( max_left + decal_left + 4 ) * 2 * AvailableTile::Base::TILE_SIZE,
        ( max_top + decal_top + 4 ) * 2 * AvailableTile::Base::TILE_SIZE )

    p dungeon_image

    @tiles.each do |pr|
      dungeon_image = pr.draw( dungeon_image, decal_top, decal_left )
    end

    dungeon_image.write( 'out/dungeon.jpg' )
  end

  private

  def place_room( room, top, left )
    r = TileOnMap::Room.new( @occupied_spaces, room, top, left )
    connect_hallway( r )
    @tiles << r
  end

  def place_hallway( border )
    top = border.top - 1
    left = border.left - 1

    top -= @h if border.side == :top
    top += 1 if border.side == :bottom
    left -= @w if border.side == :left
    left += 1 if border.side == :right

    TileOnMap::Hallway.new(self, top, left )
  end

  def connect_hallway( room )
    @hallways ||= []

    border = @borders.sample

    hallway = @availables_hallways.choose( border )

    if @occupied_space.free_space?( hallway, top, left )
      @tiles << h.place( border )
    end

  end

end