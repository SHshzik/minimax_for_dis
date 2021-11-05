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
end
