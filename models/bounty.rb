require ('pg')

class Bounty
  attr_accessor :name, :species, :last_know_location, :favourite_weapon
  attr_reader :id


  def initialize(options)
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
    db.exec_prepared("save", values)[0]['id'].to_i
    db.close()
  end



end
