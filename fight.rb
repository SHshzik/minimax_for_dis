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
    friend_team.full_hp.zero? || enemy_team.full_hp.zero?
  end

  def make_move(action)
    if action == 'd'
      defences
    else
      attack(action.split(' ').map(&:to_i))
    end
  end

  def defences
    current_active.defences
  end

  def undo_defences
    current_active.undo_defences
  end

  def attack(attack_position)
    attack_unit = get_team(attack_position[0]).get_unit(attack_position[1..2])

    current_active.attack(attack_unit)
  end

  def current_active
    get_team(active_position[0])
      .units
      .find { |unit| unit.position == active_position[1..2] }
  end

  def get_team(number)
    [friend_team, enemy_team][number - 1]
  end
end
