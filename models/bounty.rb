require ('pg')

class Bounty
  attr_accessor :name, :species, :last_know_location, :favourite_weapon
  attr_reader :id


  def initialize(options)

    # why do we have options[] here? Do they refer to accessors?
    # why do we convert 'id' to an integer?

    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @last_know_location = options['last_know_location']
    @favourite_weapon = options['favourite_weapon']
  end

  def save()
    db = PG.connect({
      dbname: 'bounties',
      host: 'localhost'
    })
    sql = "
    INSERT INTO bounties
    (
      name,
      species,
      last_know_location,
      favourite_weapon
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING *
    "
    values = [@name, @species, @last_know_location, @favourite_weapon]
    db.prepare("save", sql)

    # what's going on in the next line? Why are we converting to integer again?
    db.exec_prepared("save", values)[0]['id'].to_i
    db.close()
  end

  def self.all()
    db = PG.connect({
      dbname: 'bounties',
      host: 'localhost'
      })
    sql = "SELECT * FROM bounties"

    # why is values = []?
    values = []
    db.prepare("all", sql)
    bounties = db.exec_prepared("all", values)
    db.close()

    bounties_as_objects = bounties.map{|bounty| Bounty.new(bounty)}
    return bounties_as_objects
  end

  def self.delete_all()
    db = PG.connect({
      dbname: 'bounties',
      host: 'localhost'
      })
      sql = "DELETE FROM bounties"

      # why is values = []?
      values = []
      db.prepare("delete_all", sql)
      db.exec_prepared("delete_all", values)
      db.close()
  end

  def delete()
    db = PG.connect({
      dbname: 'bounties',
      host: 'localhost'
      })

      # this doesn't work even if the same works when I call it from the sql commandline (with id='1'; for example)
      sql = "DELETE FROM bounties WHERE id = $1"
      values = [@id]
      db.prepare("delete_1", sql)
      db.exec_prepared("delete_1", values)
      db.close()
    end

  def update()
    db = PG.connect({
      dbname: 'bounties',
      host: 'localhost'
      })
      sql = "UPDATE bounties
      SET (
        name,
        species,
        last_know_location,
        favourite_weapon
        ) =
        (
          $1, $2, $3, $4
          ) WHERE id = $5
          "
          values = [@name, @species, @last_know_location, @favourite_weapon]
          db.prepare("update", sql)
          db.exec_prepared("update", values)
          db.close()
  end


end
