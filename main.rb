# frozen_string_literal: true

require './units/empire/warrior/squire'
require './units/empire/hero/knight'
require './units/empire/support/acolyte'
require './units/greenskin/goblin'
require './fight'
require './team'

friend_unit_1 = Squire.new([1, 1])
friend_unit_2 = Knight.new([1, 2])
friend_unit_3 = Squire.new([1, 3])
friend_unit_4 = Acolyte.new([2, 2])

enemy_unit_1 = Goblin.new([1, 1])
enemy_unit_2 = Goblin.new([3, 1])

friend_team = Team.new(
  [friend_unit_1, friend_unit_2, friend_unit_3, friend_unit_4]
)

enemy_team = Team.new([enemy_unit_1, enemy_unit_2])

fight = Fight.new(friend_team, enemy_team)

def make_move(fight, action)
end

until fight.end?
  print 'Active position: '
  position = gets.chomp.split(' ')
  fight.set_active_position(position)

  print 'Next move: '
  action = gets.chomp

  make_move(fight, action)

  fight.clear_active_position

  puts "friend_team hp: #{friend_team.full_hp}"
  puts "enemy_team hp: #{enemy_team.full_hp}"
end
