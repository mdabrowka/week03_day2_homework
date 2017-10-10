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


end
