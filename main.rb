# frozen_string_literal: true

require "./units/empire/warrior/squire"
require "./units/empire/hero/knight"
require "./units/empire/support/acolyte"
require "./units/greenskin/goblin"
require "./units/greenskin/goblin_archer"
require "./units/net_human/thug"
require "./units/net_human/peasant"
require "./fight"
require "./team"

friend_team = Team.new(
  [
    Squire.new([1, 1]),
    Knight.new([2, 1]),
    Squire.new([3, 1]),
    Acolyte.new([2, 2])
  ]
)

enemy_team = Team.new(
  [
    Thug.new([1, 1]),
    Thug.new([3, 1]),
    Thug.new([2, 2])
  ]
)

fight = Fight.new(friend_team, enemy_team)

until fight.end?
  print "Active position: "
  position = gets.chomp.split(" ").map(&:to_i)
  fight.set_active_position(position)

  move = fight.get_next_step if fight.active_position[0] == 1
  puts move if fight.active_position[0] == 1

  print "Next move: "
  action = gets.chomp

  fight.make_move(action)

  if action.length == 5
    print "miss?: "
    miss = gets.chomp == "1"
    fight.undo_attack(action.split(' ').map(&:to_i)) if miss
  end

  fight.clear_active_position

  puts "friend_team hp: #{friend_team.full_hp}"
  puts "enemy_team hp: #{enemy_team.full_hp}"
end
