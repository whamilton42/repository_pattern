require 'cannon'

class CannonRepository

  def initialize(db)
    @db = db
  end

  def persist(cannon)
    attributes = {
      weight: cannon.weight,
      length: cannon.length,
      bore: cannon.bore,
      last_fired_at: cannon.last_fired_at
    }
    row = @db[:cannons].where(id: cannon.id).first

    if row
      @db[:cannons].where(id: cannon.id).update(attributes)
    else
      @db[:cannons].insert(attributes)
    end
  end

  def find_ready_to_fire
    rows = @db[:cannons].where('last_fired_at IS NULL OR
                                last_fired_at < ?', 1.minute.ago)
    rows.map { |row| build_cannon(row) }
  end


  private

  def build_cannon(row)
    Cannon.new(row)
  end

end
