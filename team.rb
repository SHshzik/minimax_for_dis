# frozen_string_literal: true

require "./services/get_attack_position"

# The Team present team with 6 positions heroes
class Team
  attr_reader :units

  def initialize(units)
    @units = units
  end

  def initialize_copy(original_team)
    @units = original_team.units.map(&:clone)
  end

  def full_hp
    units.map(&:current_hp).reduce(:+)
  end

  def get_unit(position)
    @units.find { |unit| unit.position == position }
  end

  def get_need_heal_positions
    units.filter { |unit| unit.current_hp < unit.full_hp }.map(&:position)
  end

  def get_can_attack_position(enemy_unit, enemy_team)
    GetAttackPosition.call(enemy_unit.position).call(enemy_team, self)
  end

  def have_first_line?
    units
      .filter { |unit| unit.position[1] == 1 && unit.current_hp.positive? }
      .count > 0
  end

end
