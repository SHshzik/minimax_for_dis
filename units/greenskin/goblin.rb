# frozen_string_literal: true

require './units/unit'

# The Goblin represent goblin unit
class Goblin < Unit
  def full_hp
    50
  end

  def dmg
    15
  end

  def initiative
    30
  end
end
