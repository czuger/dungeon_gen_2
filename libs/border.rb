class Border

  attr_reader :top, :left, :side

  def initialize( top, left, side )
    @top = top
    @left = left
    @side = side
  end

  def draw( dungeon_image )
    gc = Magick::Draw.new
    gc = gc.fill_opacity( 0.35 )
    draw_top = (@top-1)*Room::TILE_SIZE
    draw_left = (@left-1)*Room::TILE_SIZE

    gc.rectangle( draw_left, draw_top, draw_left+Room::TILE_SIZE, draw_top+Room::TILE_SIZE )
    gc.draw( dungeon_image )
    dungeon_image
  end

  def <=>( border )
    return -1 if @top < border.top
    return 1 if @top > border.top

    return -1 if @left < border.left
    return 1 if @left > border.left
  end
end