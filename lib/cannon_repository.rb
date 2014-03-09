require 'cannon'

class CannonRepository

  @@table = :cannons

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
    row = @db[@@table].where(id: cannon.id).first

    if row
      @db[@@table].where(id: cannon.id).update(attributes)
    else
      @db[@@table].insert(attributes)
    end
  end

  def find_ready_to_fire
    rows = @db[@@table].where('last_fired_at IS NULL OR
                                last_fired_at < ?', 1.minute.ago)
    rows.map { |row| build_cannon(row) }
  end


  private

  def build_cannon(row)
    Cannon.new(row)
  end

end
