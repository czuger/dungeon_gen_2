require_relative '../rooms/room_element'

class DungeonElement

  def initialize
    @elements = []
  end

  def set_cases( cases )
    @elements.each do |element|
      cases[ element.position.hash_key ] = element.element_type
    end
  end

end