# frozen_string_literal: true

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
    start = enemy_unit.position[0] - 1
    end1 = enemy_unit.position[0] + 1
    units.filter do |unit|
      (start..end1).to_a.include?(unit.position[0])
    end.map(&:position)
  end

  def have_first_line?
    units
      .filter { |unit| unit.position[1] == 1 && unit.current_hp.positive? }
      .positive?
  end

end
