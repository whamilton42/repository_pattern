class CannonFirer

  def initialize(cannon_repository)
    @cannon_repository = cannon_repository
  end

  def fire(cannon, target, time)
    target.destroy
    cannon.last_fired_at = time
    @cannon_repository.persist(cannon)
  end

end