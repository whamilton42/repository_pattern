require 'cannon'

class CannonRepository

  @@table = :cannons

  def initialize(adaptor)
    @adaptor = adaptor
  end

  def persist(cannon)
    attributes = {
      weight: cannon.weight,
      length: cannon.length,
      bore: cannon.bore,
      last_fired_at: cannon.last_fired_at
    }
    existing_record = @adaptor.find_by_id(cannon.id)

    if existing_record
      @adaptor.update(cannon.id, attributes)
    else
      @adaptor.insert(attributes)
    end
  end

  def find_ready_to_fire
    existing_records = @adaptor.where('last_fired_at IS NULL OR
                                       last_fired_at < ?', 1.minute.ago)
    existing_records.map { |record| build_cannon(record) }
  end


  private

  def build_cannon(record)
    Cannon.new(record)
  end

end
