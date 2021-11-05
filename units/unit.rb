# frozen_string_literal: true

# The Unit class represent base class unit's
class Unit
  def initialize(position, current_dmg = 0)
    @position = position
    @current_hp = full_hp - current_dmg
  end

  def to_s
    "#{self.class} - #{@current_hp}"
  end
end
