require('pry')
require_relative('models/bounty.rb')

#Bounty.delete_all()

bounty_1 = Bounty.new(
  {
    'name' => 'Rose',
    'species' => 'human',
    'last_know_location' => 'Glasgow',
    'favourite_weapon' => 'bare hands'
  }
)


bounty_2 = Bounty.new(
  {
    'name' => 'Fiona',
    'species' => 'hippo',
    'last_know_location' => 'Zoo',
    'favourite_weapon' => 'hippo bite'
  }
)

binding.pry
nil
