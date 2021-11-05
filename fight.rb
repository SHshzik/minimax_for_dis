# frozen_string_literal: true

# The Fight class save info about teams and some data
class Fight
  attr_reader :friend_team, :enemy_team

  def initialize(friend_team, enemy_team)
    @friend_team = friend_team
    @enemy_team = enemy_team
  end

  def initialize_copy(original_fight)
    @friend_team = original_fight.friend_team.dup
    @enemy_team = original_fight.enemy_team.dup
  end

  def set_active_position(position)
    @active_position = position
  end
end
