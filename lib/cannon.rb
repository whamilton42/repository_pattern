class Cannon

  attr_reader :weight, :length, :bore, :id
  attr_accessor :last_fired_at

  include Comparable

  def initialize(args)
    @id = args[:id]

    @weight = args.fetch(:weight)
    @length = args.fetch(:length)
    @bore = args.fetch(:bore)
    @last_fired_at = args.fetch(:last_fired_at)
  end

  def <=>(other)
    id <=> other.id
  end

  def range
    weight * 1.2 * length - (bore ** 0.9)
  end

end
