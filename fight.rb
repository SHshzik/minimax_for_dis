# frozen_string_literal: true

# The Fight class save info about teams and some data
class Fight
  attr_reader :friend_team, :enemy_team, :active_position

  def initialize(friend_team, enemy_team)
    @friend_team = friend_team
    @enemy_team = enemy_team
  end

  def to_s
    "#{friend_team.full_hp} / #{enemy_team.full_hp}"
  end

  def initialize_copy(original_fight)
    @friend_team = original_fight.friend_team.dup
    @enemy_team = original_fight.enemy_team.dup
  end

  def set_active_position(position)
    @active_position = position
  end

  def clear_active_position
    @active_position = nil
  end

  def end?
    @friend_team.full_hp.zero? || @enemy_team.full_hp.zero?
  end
end
