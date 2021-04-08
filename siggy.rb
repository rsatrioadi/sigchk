class Siggy

  @@m = -2.841300097
  @@c = 839.7111839

  attr_reader :bound

  def initialize(pos_x,pos_y,ratio=2.2358)
    @bound = []
    @bound << ( pos_x * @@m.abs + 0 )
    @bound << (( pos_y + 20 ) * @@m + @@c )
    @bound << (( pos_x + ratio * 20 ) * @@m.abs )
    @bound << ( pos_y * @@m + @@c )
  end

  def self.from_array(arr)
    r = Siggy.new( 0,0 )
    r.send( :bound=, arr )
    return r
  end

  def within_range(other,epsilon=2)
    other = other.bound if other.is_a?( Siggy )
    return @bound.zip( other ).map { |x,y| (y-x).abs }.all? { |delta| delta<epsilon }
  end

  def ==(other)
    return within_range(other)
  end

  private
  attr_writer :bound
end
