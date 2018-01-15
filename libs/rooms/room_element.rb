class RoomElement

  TYPES = [ :hall, :room ]

  attr_reader :position, :element_type

  def initialize( position, element_type )

    raise "#{self.class}##{__method__} : element_type not in TYPES array '#{element_type.inspect}'" unless TYPES.include?( element_type )

    @element_type = element_type
    @position = position
  end

end