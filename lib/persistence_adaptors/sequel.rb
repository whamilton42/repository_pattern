class SequelPersistenceAdaptor

  def initialize(db, table)
    @db = db
    @table = table
  end

  def where(*args)
    @db[@table].where(args)
  end

  def find_by_id(id)
    @db[@table].where(id: id).first
  end

  def update(id, attributes)
    @db[@table].where(id: id).update(attributes)
  end

  def insert(attributes)
    @db[@table].insert(attributes)
  end

end